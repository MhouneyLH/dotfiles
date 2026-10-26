#!/usr/bin/env python3
"""Claude Code status line: spent money and token usage, for this session and in total.

Input: the status line JSON on stdin (see https://code.claude.com/docs/en/statusline).

- Session cost comes from `cost.total_cost_usd`.
- Total cost is a ledger of the highest cost seen per session id. Transcripts do not
  contain prices, so the ledger only counts sessions from the first run of this script.
- Tokens are summed from the transcripts under <config dir>/projects, so they include
  history. Only "new" tokens are counted (input + cache writes + output). Cache reads
  are left out because every turn re-reads the whole context and would inflate the sum.
- Plan limits (`rate_limits`, subscription plans only) show the share left in the 5 hour and 7 day
  windows plus the time until they reset; the context window share left comes from `context_window`.
- If the caveman plugin's badge script exists, its output is prepended.
- Parsed transcripts are cached by mtime and size, so a refresh only re-reads files that changed.
"""
import json
import os
import subprocess
import sys
import tempfile
import time
from pathlib import Path

CONFIG_DIR = Path(os.environ.get("CLAUDE_CONFIG_DIR", Path.home() / ".claude"))
STATE_DIR = Path(os.environ.get("CLAUDE_STATUSLINE_STATE_DIR", CONFIG_DIR / "statusline-state"))
LEDGER = STATE_DIR / "cost-ledger.json"
TOKEN_CACHE = STATE_DIR / "token-cache.json"


def load_json(path, default):
    try:
        with open(path) as f:
            return json.load(f)
    except (OSError, json.JSONDecodeError):
        return default


def save_json(path, data):
    path.parent.mkdir(parents=True, exist_ok=True)
    fd, tmp = tempfile.mkstemp(dir=path.parent, suffix=".tmp")
    with os.fdopen(fd, "w") as f:
        json.dump(data, f)
    os.replace(tmp, path)


def file_usage(path):
    """Map of message id -> new tokens for one transcript. Content blocks repeat the same id, so the last one wins."""
    usage = {}
    try:
        with open(path) as f:
            for line in f:
                if '"usage"' not in line:
                    continue
                try:
                    message = json.loads(line).get("message")
                except json.JSONDecodeError:
                    continue
                if not isinstance(message, dict) or not isinstance(message.get("usage"), dict):
                    continue
                u = message["usage"]
                usage[message.get("id") or line[:64]] = (
                    (u.get("input_tokens") or 0)
                    + (u.get("cache_creation_input_tokens") or 0)
                    + (u.get("output_tokens") or 0)
                )
    except OSError:
        pass
    return usage


def token_totals(current_transcript):
    """(tokens in the current session, tokens in all sessions). Message ids are unique across resumed sessions."""
    cache = load_json(TOKEN_CACHE, {})
    seen = {}
    dirty = False
    for path in (CONFIG_DIR / "projects").rglob("*.jsonl"):
        key = str(path)
        try:
            st = path.stat()
        except OSError:
            continue
        entry = cache.get(key)
        if not entry or entry["mtime"] != st.st_mtime_ns or entry["size"] != st.st_size:
            entry = {"mtime": st.st_mtime_ns, "size": st.st_size, "usage": file_usage(path)}
            cache[key] = entry
            dirty = True
        seen[key] = entry
    if len(seen) != len(cache):
        cache = seen
        dirty = True
    if dirty:
        save_json(TOKEN_CACHE, cache)

    total = {}
    for entry in seen.values():
        total.update(entry["usage"])
    session = seen.get(str(current_transcript), {}).get("usage", {})
    return sum(session.values()), sum(total.values())


def cost_totals(session_id, session_cost):
    ledger = load_json(LEDGER, {})
    if session_id and session_cost > ledger.get(session_id, 0):
        ledger[session_id] = session_cost
        save_json(LEDGER, ledger)
    return sum(ledger.values())


def tokens(n):
    if n >= 1_000_000:
        return f"{n / 1_000_000:.1f}M"
    if n >= 1_000:
        return f"{n / 1_000:.0f}k"
    return str(n)


def left(label, window):
    """'[5h] 77% left (2h13m)' for one rate limit window, or '' when the field is missing."""
    used = (window or {}).get("used_percentage")
    if used is None:
        return ""
    text = f"[{label}] {max(0, 100 - used):.0f}% left"
    resets_at = window.get("resets_at")
    if resets_at:
        minutes = max(0, int(resets_at - time.time())) // 60
        text += f" ({minutes // 1440}d{minutes % 1440 // 60}h)" if minutes >= 1440 else f" ({minutes // 60}h{minutes % 60:02d}m)"
    return text


def caveman_badge(raw):
    script = CONFIG_DIR / "hooks" / "caveman-statusline.sh"
    if not script.is_file():
        return ""
    try:
        return subprocess.run(["bash", str(script)], input=raw, capture_output=True, text=True, timeout=2).stdout
    except (OSError, subprocess.SubprocessError):
        return ""


def main():
    raw = sys.stdin.read()
    try:
        data = json.loads(raw)
    except json.JSONDecodeError:
        data = {}

    session_cost = float((data.get("cost") or {}).get("total_cost_usd") or 0)
    session_tokens, total_tokens = token_totals(data.get("transcript_path") or "")
    total_cost = cost_totals(data.get("session_id"), session_cost)

    dim, reset = "\033[2m", "\033[0m"
    limits = data.get("rate_limits") or {}
    context = (data.get("context_window") or {}).get("used_percentage")
    plan = " · ".join(filter(None, [left("5h", limits.get("five_hour")), left("7d", limits.get("seven_day"))]))
    first = " ".join(filter(None, [
        caveman_badge(raw),
        f"📊 {plan}" if plan else "",
        f"🧠 {max(0, 100 - context):.0f}% ctx left" if context is not None else "",
    ]))
    if first:
        print(first)
    print(
        f"💸 ${session_cost:.2f} {dim}session{reset} · ${total_cost:.2f} {dim}total{reset}"
        f"  🔢 {tokens(session_tokens)} {dim}session{reset} · {tokens(total_tokens)} {dim}total{reset}"
    )


if __name__ == "__main__":
    main()
