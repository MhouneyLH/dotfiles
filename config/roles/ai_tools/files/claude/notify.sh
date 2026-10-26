#!/usr/bin/env bash
# Desktop notification with the cat sound, used by Claude Code hooks.
# Usage: notify.sh <title> <body>
# Sound is played here (not by Plasma) so it works the same for every hook event.
SOUND="$HOME/.local/share/sounds/huh_cat_cut.mp3"

[ -f "$SOUND" ] && (pw-play "$SOUND" >/dev/null 2>&1 &)
gdbus call --session --dest org.freedesktop.Notifications \
    --object-path /org/freedesktop/Notifications \
    --method org.freedesktop.Notifications.Notify \
    "Claude Code" 0 "dialog-information" "${1:-Claude Code}" "${2:-}" "[]" \
    "{'suppress-sound': <true>}" 8000 >/dev/null 2>&1
exit 0
