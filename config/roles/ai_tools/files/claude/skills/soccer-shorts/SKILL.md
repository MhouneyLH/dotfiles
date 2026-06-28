---
name: soccer-shorts
description: Generate YouTube Shorts / Reels scripts for World Cup 2026 soccer content. Follows the SS Content Master strategy — Hook (0-5s) → Story → Peak Answer format, optimized for US engagement 5-8 PM EST window. Use for /soccer-shorts, "generate reel", "soccer script", "write a short for [game]", "what should I post for [match]".
---

Generate YouTube Shorts scripts following the SoccerScene content master strategy.

## Formula

Every script has exactly 3 parts:

1. **HOOK (0-5s)** — opens with the upcoming match. Pattern: "[Team] plays [today/tomorrow], but [dark secret they don't know about]..."
2. **STORY** — historical scandal, insider fact, or controversial truth. 45–60 seconds spoken (~120–150 words). Present tense. Fast-paced. No filler.
3. **PEAK ANSWER** — the reveal. 1–2 sentences max. Punchy. Shareable. Never telegraph it in the hook.

## Publishing Rules

- **Upload window:** 5:00–8:00 PM EST (= 4–7 AM ICT next day)
- **Timing:** Day BEFORE the match. If same-day game: as early as possible within the 5–8 PM EST window, before kickoff
- **Never:** during the match (people watching, not scrolling), or the day after (momentum dead)
- **Optimal lead time:** 18–36 hours before kickoff

## Global Hashtags (always include)

```
#Soccer #WorldCup #SoccerScene #SoccerShorts
```

Add match-specific: `#[Team1]vs[Team2] #[Team1] #[Team2] #WorldCup2026`

## Comment Accelerator (mandatory — pin immediately after upload)

Format: *"Do you think [controversial claim from video]? Drop your score prediction below! 👇"*

## Phase Map — pick story that ties to a team playing

### Phase 1: Dark History & Scandals

| Story | Tie to match |
|-------|-------------|
| England's Phantom Goal (1966 ghost goal) | Any England match |
| England's 1966 trophy → ball never crossed the line | England match |
| Ecuador's Eligibility Scandal (Byron Castillo 2022) | Any Ecuador match |
| Ronaldo's Secret Tears (2022 benching by manager) | Portugal match |
| The Illegal Match — Disgrace of Gijón 1982 | Germany / Austria match |
| Messi's Debut Nightmare (2006 benching) | Argentina match |
| The Threatened Finalist — Luis Monti 1930 death threats | Argentina / Uruguay match |
| Why America Hated Soccer (1998 rebellion) | USA match |
| The $10M Blunder (goalie error → Nike contract gone) | Any high-stakes match |
| Neymar's 2018 Illusion (14min ground time = tactic) | Brazil match |
| The Stolen Trophy Plot (1966 Jules Rimet) | England / Uruguay match |
| Zidane's Real Words — exact phrase Materazzi said | France match |
| The Ref Who Disappeared — Byron Moreno 2002 | Italy / South Korea match |
| Mbappe's Secret Clause (contract forces team tactics) | France match |
| Maradona's 1994 Setup (FIFA allegedly tipped testers) | Argentina match |
| The Ghost Team of 1974 — Zaire death threats | Any underdog match |
| Italy's Ultimate Curse — Baggio 1994 penalty | Italy match |
| The Hypnotized Goalie 1982 | Any penalty-likely match |
| The $1B Qatar Ghost City | General WC context |
| The Rigged 1978 Final — military dictator | Argentina match |
| Suarez's Vampire Instinct (tactical bite) | Uruguay match |

### Phase 2: US Soccer Rise & Predictions

| Story | Tie to match |
|-------|-------------|
| Pulisic's Europe Escape (Chelsea coach's 5 words) | USA match |
| Banned US Fan Traditions (insurance law reason) | USA home match |
| The AI World Cup Predictor (underdog picks) | Any match |
| The 17-Year-Old US Prodigy (rejected Real Madrid) | USA match |
| New York's Multi-Million Tax (grass thrown away post-game) | USA group match |
| Why Mbappe Fears the US (physicality + humidity) | USA vs France |
| The Manager's $5M Superstition (same unwashed suit) | Any match |
| The Messi Effect Exploded (1000% ticket price rise) | Any Messi match |
| 3 Dark Horses to Watch | Before knockout rounds |
| Is the World Cup Rigged? (draw manipulation rumors) | Group stage |
| The Turf War Scandal (grass over concrete + ACL risk) | US-hosted match |
| Hollywood's Soccer Takeover (Reynolds/Ferrell inflate values) | USA context |
| The Hidden Drone Spies (FIFA silent warning) | Any match |
| The No-Fly Zone Match (military no-fly activated) | High-security match |
| The $100M Nike vs Adidas War (players alter playstyle) | Any match |
| The 100-Degree Nightmare (FIFA refused to move time slot) | US summer match |

## Output Format

```
===== REEL SCRIPT =====
TITLE: [engaging title ≤60 chars]
MATCH: [Team A vs Team B — Date, Time EST]
PHASE: [1 or 2] | STORY: [story name from phase map]

HOOK (0-5s):
[exact spoken words]

STORY (45-60s):
[spoken script — conversational, present tense, fast-paced, ~130 words]

PEAK ANSWER:
[the reveal — 1-2 sentences, punchy, never hedged]

---
UPLOAD BY: [date] at 5–8 PM EST (ideally [X]h before kickoff)
HASHTAGS: #Soccer #WorldCup #SoccerScene #SoccerShorts #[Team1]vs[Team2] #[Team1] #[Team2] #WorldCup2026
PINNED COMMENT: "[polarizing question] Drop your score prediction below! 👇"
=======================
```

## Trigger n8n workflow from Claude Code

Call the webhook to generate + deliver script via Telegram:

```bash
# Trigger with specific match (set N8N_BASE_URL in your env)
curl -s -X POST "${N8N_BASE_URL}/webhook/soccer-shorts" \
  -H "Content-Type: application/json" \
  -d '{"featured_match": "England vs Ecuador"}'

# Trigger with no match (uses today's story, team name as context)
curl -s -X POST "${N8N_BASE_URL}/webhook/soccer-shorts" \
  -H "Content-Type: application/json" \
  -d '{}'

# Approve a script for video generation (triggers video workflow)
curl -s -X POST "${N8N_BASE_URL}/webhook/soccer-shorts-approve" \
  -H "Content-Type: application/json" \
  -d '{"approved": true, "script": "PASTE_SCRIPT_HERE", "title": "England Phantom Trophy"}'
```

Set `N8N_BASE_URL` in your shell (e.g. `http://hl-worker-01:30xxx` or your Traefik hostname).

## Trigger phrases

- `/soccer-shorts [match]`
- "generate reel for [match]"
- "soccer script for [game]"
- "write a short for [team] vs [team]"
- "what should I post for [match]"
- "trigger n8n for [match]"
- "reel ideas for today's game"
