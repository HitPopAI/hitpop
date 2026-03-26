# 🚀 GitHub Launch Workflow

Coordinate a proper open-source launch to maximize visibility of hitpop-skills in the developer community.

## Pre-Launch (Day -3 to -1)

### Polish the Repo
```
🧠 Planner → 📣 Promoter: "audit repo readiness"
📣 Promoter checks:
  - [ ] README has badges, architecture diagram, quick-start
  - [ ] All 15 skills have clear SKILL.md with working examples
  - [ ] LICENSE file present (MIT)
  - [ ] .gitignore is clean
  - [ ] No hardcoded API keys anywhere

🧠 Planner → 💡 Creative: "design a demo GIF showing hitpop in action"
💡 Creative → storyboard for demo
💻 Producer → records/generates demo GIF
📣 Promoter → adds GIF to README
```

### Prepare Launch Content
```
🧠 Planner → 📣 Promoter: "draft all launch content"
📣 Promoter → ✍️ Writer: "write compelling descriptions"

Drafts needed (all require user approval):
  1. awesome-openclaw-skills PR description
  2. ClawHub skill descriptions (for each skill)
  3. Reddit post (r/OpenClaw)
  4. Reddit post (r/ClaudeAI)
  5. Show HN post
  6. Twitter/X announcement thread
  7. dev.to tutorial article outline

📣 Promoter → 📰 Scout: "what's the best time to post this week?"
📰 Scout → posting schedule recommendation
```

## Launch Week

### Day 1: GitHub Polish
```
📣 Promoter:
  - Final README update with demo GIF
  - Add GitHub topics: openclaw, ai-video, video-generation, skills
  - Create GitHub release v1.0.0
  USER APPROVAL → push changes
```

### Day 2: awesome-openclaw-skills
```
📣 Promoter:
  - Draft PR to VoltAgent/awesome-openclaw-skills
  - Include: repo link, ClawHub link, short description, category placement
  USER APPROVAL → submit PR
```

### Day 3: ClawHub
```
📣 Promoter → 💻 Producer:
  - Run `clawhub publish` for each skill
  - Write compelling ClawHub descriptions
  USER APPROVAL → publish
```

### Day 4: Reddit
```
📣 Promoter:
  - Post to r/OpenClaw (focus on skills ecosystem value)
  - Post to r/ClaudeAI (focus on Claude Code integration)
  USER APPROVAL → post
  
  After posting:
  - Monitor comments for 24h
  - Draft replies to questions
  USER APPROVAL → reply
```

### Day 5: Hacker News
```
📣 Promoter:
  - Draft Show HN: title + description
  - Lead with problem solved, not tool name
  USER APPROVAL → submit

  After posting:
  - Monitor and draft replies to comments
  USER APPROVAL → reply to each
```

### Day 6: Twitter/X
```
📣 Promoter → ✍️ Writer:
  - Write announcement thread (5-7 tweets)
  - Include: problem, solution, demo GIF, link, CTA
  USER APPROVAL → post thread
```

### Day 7: Tutorial Article
```
📣 Promoter → ✍️ Writer:
  - Write "How to make a product video with AI in 60 seconds"
  - Include: step-by-step, code snippets, actual output screenshots
  - Publish on dev.to or Medium
  USER APPROVAL → publish
```

## Post-Launch (Week 2+)

### Ongoing Community Engagement
```
📰 Scout: daily scan for relevant discussions
📣 Promoter: draft helpful replies (max 3/day)
USER APPROVAL → post each reply
```

### Metrics Tracking
```
📣 Promoter reports weekly:
  - GitHub stars count
  - ClawHub install count
  - Reddit upvotes + comments
  - HN points
  - New issues/PRs from community (sign of real usage)
```

## Safety Rules (Learned from Tianrun's Henry Incident)

1. **EVERY external action needs user approval** — no exceptions
2. **Max 3 GitHub interactions per day** — comments, PR submissions, issue replies
3. **Max 1 post per community per week** — no spam
4. **Never @ the same person twice** — ever
5. **Never rush** — if user says "go faster", Promoter does NOT skip quality checks
6. **Be helpful first** — provide value before mentioning hitpop
7. **Accept rejection gracefully** — if a PR is rejected or post is downvoted, learn and move on
