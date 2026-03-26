# 🎬 Hitpop

**Video AI Multi-Agent System for OpenClaw, Claude Code, and Cursor.**

9 agents + 23 skills. Say "make me a video" → get a finished video.

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Agents](https://img.shields.io/badge/agents-9-orange.svg)](#agents)
[![Skills](https://img.shields.io/badge/skills-19-blue.svg)](#skills)
[![OpenClaw](https://img.shields.io/badge/OpenClaw-compatible-purple.svg)](https://docs.openclaw.ai)

[Quick Start](#quick-start) •
[Architecture](#architecture) •
[Agents](#agents) •
[Skills](#skills) •
[Workflows](#workflows) •
[Contributing](#contributing)

---

## What Is This?

Hitpop is a multi-agent video production system. Users describe what they want in plain language. A fleet of 9 specialized AI agents collaborates to deliver finished videos — from creative direction to social media publishing.

No video production knowledge required. No code required. Just talk.

```
You:    "Make me a headphone product video for TikTok with voiceover"

Hitpop: Analyzes your request
        → Creative designs visual style
        → Producer generates video from your product image (Vidu Q2)
        → Writer writes narration script
        → Producer adds voiceover (Edge TTS) + subtitles (Whisper) + BGM
        → Critic checks quality (IMPACT score ≥ 20/30)
        → Reviewer final approval
        → Exports TikTok 9:16 format
        → Delivers video + platform copy (title, description, hashtags)
```

Works with **OpenClaw**, **Claude Code**, and **Cursor**.

---

## Quick Start

### 1. Clone

```bash
git clone https://github.com/HitPopAI/hitpop.git
cd hitpop
```

### 2. Set API Key

```bash
export ZHIPU_API_KEY="your-key-from-bigmodel.cn"
```

### 3. Install (OpenClaw)

```bash
chmod +x setup.sh
./setup.sh
```

### 3. Install (Claude Code / Cursor)

```bash
# Claude Code
cp -r skills/* .claude/skills/
cp -r agents/* .claude/skills/

# Cursor
cp -r skills/* .cursor/skills/
```

### 4. Use

Talk to the Main agent:

```
> Make me a product promo video
> Make me a 15-second TikTok about AI tools
> Generate 5 social media videos in batch
> Help me launch this project on GitHub
```

---

## Architecture

```
                         ┌──────────────┐
                         │   👤 User    │
                         └──────┬───────┘
                                │
                    ┌───────────▼───────────┐
                    │  🎬 Main              │
                    │  Chief Strategy Officer│
                    └───────────┬───────────┘
                                │
                         ┌──────▼───────┐
                         │  🧠 Planner  │
                         └──────┬───────┘
                                │
       ┌────────────────────────┼────────────────────────┐
       │                        │                        │
 ┌─────▼─────┐           ┌─────▼─────┐           ┌─────▼─────┐
 │ 💡Creative│◄── ⚔️ ──►│ 🎯 Critic │           │ 📰 Scout  │
 └─────┬─────┘           └─────┬─────┘           └───────────┘
       │                       │
 ┌─────▼─────┐           ┌─────▼─────┐
 │ ✍️ Writer │           │ 💻Producer│──→ 15 Skills
 └─────┬─────┘           └───────────┘
       │
 ┌─────▼─────┐           ┌───────────┐
 │ 🔍Reviewer│           │ 📣Promoter│
 └───────────┘           └───────────┘

Skills (Producer's toolbox):
  Generation:  gen-video · gen-image · comfyui
  Templates:   rendervid · shotstack · json2video · creatomate
  Post-prod:   edit · voiceover · lipsync · subtitle · music · twick
  Distribute:  publish · director · pipeline
```

### Agent Philosophy

Every agent operates as a higher-dimensional intelligence — not a passive tool, but an autonomous thinker with standards and the authority to push back.

| Principle | Meaning |
|---|---|
| **Never execute blindly** | Diagnose before producing. Ask the questions that expose the gap between vague wish and concrete vision. |
| **Never let mediocrity ship** | Would a stranger stop scrolling to watch this? If not, it goes back. |
| **Never confuse activity with progress** | One video that changes minds > ten videos nobody watches. |

### Adversarial Collaboration

| Axis | Agents | Dynamic |
|---|---|---|
| Creativity vs. Taste | 💡 Creative ↔ 🎯 Critic | Bold ideas refined through rigorous evaluation |
| Draft vs. Review | ✍️ Writer ↔ 🔍 Reviewer | Scripts polished through iterative feedback |
| Speed vs. Quality | 💻 Producer ↔ 🎯 Critic | Fast execution held to quality standards |

---

## Agents

| # | Agent | Role | Superpower |
|---|---|---|---|
| 0 | 🎬 **Main** | Chief Strategy Officer | Diagnoses before acting, challenges weak briefs |
| 1 | 🧠 **Planner** | Production Architect | Designs minimum-viable pipelines with failure modes |
| 2 | 💡 **Creative** | Creative Director | Would rather ship nothing than ship boring |
| 3 | 🎯 **Critic** | Quality Sovereign | Absolute veto power, IMPACT scoring (≥20/30 to pass) |
| 4 | 💻 **Producer** | Master Craftsman | Executes all technical work via 23 skills |
| 5 | ✍️ **Writer** | Narrative Architect | "The viewer gives you 1.5 seconds. Earn the next 13.5." |
| 6 | 🔍 **Reviewer** | Audience Proxy | Watches output as a stranger scrolling at 2am |
| 7 | 📰 **Scout** | Intelligence Analyst | Delivers insight, not data. "WHY is it trending?" |
| 8 | 📣 **Promoter** | Growth Strategist | Builds reputation through genuine value (never auto-publishes) |

Each agent has 3 files in `agents/<id>/`:

| File | Purpose |
|---|---|
| `soul.md` | Identity, philosophy, decision principles |
| `agent.md` | Model config, tool permissions, inter-agent protocols |
| `user.md` | Project context, preferences, reference data |

---

## Skills

23 skills that Producer uses as its toolbox. All in `skills/`:

| Category | Skill | Backend | Cost |
|---|---|---|---|
| **Generation** | `hitpop-gen-video` | Vidu Q2 (6 models) via Zhipu API | ¥0.20-0.40 |
| | `hitpop-gen-image` | Seedream 4.0/4.5 via Zhipu API | ¥0.20-0.25 |
| | `hitpop-comfyui` | Local open-source (Flux, Wan2.1) | Free |
| **Templates** | `hitpop-rendervid` | Rendervid (open source) | Free |
| | `hitpop-shotstack` | Shotstack cloud API | Free sandbox |
| | `hitpop-json2video` | JSON2Video API | Free tier |
| | `hitpop-creatomate` | Creatomate API | Free trial |
| **Post-prod** | `hitpop-edit` | FFmpeg | Free |
| | `hitpop-voiceover` | Edge TTS / OpenAI / ElevenLabs | Free+ |
| | `hitpop-lipsync` | Wav2Lip / SadTalker / LivePortrait / HeyGen | Free+ |
| | `hitpop-subtitle` | Whisper | Free |
| | `hitpop-music` | FFmpeg + free libraries | Free |
| | `hitpop-twick` | Twick React SDK | Free |
| **Distribute** | `hitpop-publish` | FFmpeg + platform APIs | Free |
| **Reference** | `hitpop-character-anime + hitpop-character-realistic` | Character 3-view turnaround templates | Free |
| | `hitpop-product-sheet` | Product 5-angle reference + style lock | Free |
| | `hitpop-scene-guide` | Scene prompt templates by content type | Free |
| **Orchestrate** | `hitpop-director` | GLM-5-Turbo routing | ~$0.001 |
| | `hitpop-pipeline` | Checkpoint-based workflow engine | Free |

All Zhipu API calls via `https://open.bigmodel.cn/api/paas/v4/`

---

## Workflows

| Workflow | File | Description |
|---|---|---|
| 📋 Video Pipeline | `workflows/video-pipeline.md` | Full 6-phase production with quality gates |
| 📦 Batch Content | `workflows/batch-content.md` | Template-based bulk video generation |
| 🚀 GitHub Launch | `workflows/github-launch.md` | 7-day community outreach campaign |

### Quality Gates (IMPACT Score)

| Dimension | What Critic Evaluates |
|---|---|
| **I**mpact | Would a stranger stop scrolling? |
| **M**essage | Core message clear in 3 seconds? |
| **P**olish | Any artifacts, glitches, sync issues? |
| **A**udience | Matches target platform and audience? |
| **C**raft | Every frame feels intentional? |
| **T**iming | Pacing feels right? |

Pass: ≥ 20/30. Below 20: redo. Below 15: reject.

---

## Repo Structure

```
hitpop/
├── soul.md                     # 🎬 Main agent identity
├── agents.yaml                 # Agent manifest (source of truth)
├── setup.sh                    # One-command OpenClaw setup
├── README.md
├── LICENSE
│
├── agents/                     # 🤖 9 agent definitions
│   ├── planner/                #   soul.md + agent.md + user.md
│   ├── creative/
│   ├── critic/
│   ├── producer/
│   ├── writer/
│   ├── reviewer/
│   ├── scout/
│   └── promoter/
│
├── skills/                     # 🛠️ 16 video AI skills
│   ├── hitpop-gen-video/       #   SKILL.md each
│   ├── hitpop-gen-image/
│   ├── hitpop-comfyui/
│   ├── hitpop-edit/
│   ├── hitpop-voiceover/
│   ├── hitpop-lipsync/
│   ├── hitpop-subtitle/
│   ├── hitpop-music/
│   ├── hitpop-publish/
│   ├── hitpop-rendervid/
│   ├── hitpop-shotstack/
│   ├── hitpop-json2video/
│   ├── hitpop-creatomate/
│   ├── hitpop-twick/
│   ├── hitpop-director/
│   ├── hitpop-character-anime + hitpop-character-realistic/
│   ├── hitpop-product-sheet/
│   ├── hitpop-scene-guide/
│   └── hitpop-pipeline/
│
├── workflows/                  # 📋 Production templates
│   ├── video-pipeline.md
│   ├── batch-content.md
│   └── github-launch.md
│
├── examples/                   # Config examples
│   └── openclaw.json
│
└── docs/                       # Documentation
    └── installation.md
```

---

## Safety: The Henry Lesson

The Promoter agent is inspired by Tianrun Yang's CMO agent — but with critical safety improvements after his agent got banned for spamming GitHub maintainers:

1. **NEVER auto-publishes** — every external action requires user approval
2. **Rate limited** — max 3 GitHub interactions/day
3. **"Go faster" does NOT skip quality** — the exact trigger that caused the ban
4. **Helpful first, promotional second** — provide value before mentioning Hitpop

---

## Requirements

| Requirement | What needs it |
|---|---|
| `ZHIPU_API_KEY` | gen-video, gen-image, director, all agents |
| `curl` + `jq` | All API skills |
| `ffmpeg` | edit, voiceover, subtitle, music, publish |
| `python3` | subtitle (whisper), voiceover (edge-tts) |
| OpenClaw CLI (optional) | Multi-agent orchestration |

---

## Contributing

- 🐛 **Bug Reports** — Open an Issue
- 💡 **New Skills** — Add a SKILL.md in `skills/`
- 🤖 **Agent Improvements** — Improve soul.md files
- 📋 **Workflows** — Share your video production templates

---

## Inspiration

- [shenhao-stu/openclaw-agents](https://github.com/shenhao-stu/openclaw-agents) — Multi-agent architecture pattern
- [Tianrun Yang](https://eu.36kr.com/en/p/3696794545172103) — Agent fleet philosophy and the Henry lesson
- [OpenClaw](https://docs.openclaw.ai) — The platform this runs on

---

## License

[MIT](LICENSE)

---

**Built by [HitPopAI](https://github.com/HitPopAI)** · Video AI for the Agent Era
