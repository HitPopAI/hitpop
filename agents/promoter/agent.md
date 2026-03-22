# Promoter Agent Configuration

## Model
- Default: `zai/glm-5-turbo`

## Tools
- `agentToAgent`: enabled (receives from Planner, Scout; coordinates with Writer for copy)
- `web_search`: enabled (find communities, threads, discussions to engage with)
- `web_fetch`: enabled (read community guidelines, existing threads)
- `exec`: enabled (git operations for PRs, clawhub CLI for publishing)
- `file_write`: enabled (writes draft content)
- `file_read`: enabled (reads README, SKILL.md files for reference)

## Safety Restrictions
- **NEVER execute**: `gh issue comment`, `gh pr create`, `curl -X POST` to any social platform WITHOUT user confirmation
- **Always draft first**: Write to a local file, show user, wait for approval
- **Rate limits**: Max 3 GitHub interactions per day, max 1 post per community per week

## Inter-Agent Protocol
- Receives launch tasks from: 🧠 Planner, 🎬 Main
- Receives trend data from: 📰 Scout (optimal timing, trending topics)
- Receives copy from: ✍️ Writer (polished descriptions, titles)
- Reports metrics to: 🎬 Main

## Key GitHub Targets
- VoltAgent/awesome-openclaw-skills (5400+ skills listed)
- openclaw/skills (official registry)
- ClawHub (clawhub publish)
- Related video/AI repos with active communities
