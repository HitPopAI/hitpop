# 📋 Video Pipeline Workflow

Full end-to-end video production from user request to delivered video.

## Phases

### Phase 1: Brief & Research
```
🎬 Main → receives user request
🎬 Main → 🧠 Planner: "decompose this request"
🧠 Planner → 📰 Scout: "research trends for [platform]" (if needed)
📰 Scout → 🧠 Planner: trend report
🧠 Planner → returns pipeline plan to 🎬 Main
🎬 Main → shows plan to user, gets approval
```

### Phase 2: Creative Direction
```
🧠 Planner → 💡 Creative: "design visual direction for [brief]"
💡 Creative → returns: storyboard, style guide, prompts
🧠 Planner → 🎯 Critic: "review creative direction"
🎯 Critic → PASS or REDO (loop back to Creative if REDO)
```

### Phase 3: Script & Copy
```
🧠 Planner → ✍️ Writer: "write script based on [storyboard]"
✍️ Writer → returns: scene-by-scene narration + platform copy
🧠 Planner → 🔍 Reviewer: "check script timing and readability"
🔍 Reviewer → PASS or REVISION (loop back to Writer if REVISION)
```

### Phase 4: Production
```
🧠 Planner → 💻 Producer: "execute generation plan"
💻 Producer:
  1. Generate images (Seedream 4.5/4.0)
  2. Generate video clips (Vidu Q2)
  3. Generate voiceover (Edge TTS)
  4. Generate subtitles (Whisper)
  5. Mix audio (FFmpeg: voice + BGM)
  6. Merge everything (FFmpeg: video + audio + subtitles)
  7. Export for target platform (FFmpeg: resize)

After steps 2 and 6:
🧠 Planner → 🎯 Critic: "review output quality"
🎯 Critic → PASS or REDO
```

### Phase 5: Final Review
```
🧠 Planner → 🔍 Reviewer: "final quality check"
🔍 Reviewer → checklist: visual, audio, subtitles, platform specs
🔍 Reviewer → APPROVED or NEEDS REVISION
```

### Phase 6: Delivery
```
🔍 Reviewer → 🎬 Main: "approved, ready to deliver"
🎬 Main → user: final video + download link + platform copy
🎬 Main → user: "need anything adjusted?"
```

## Quality Gates

| Gate | When | Who | Pass Criteria |
|---|---|---|---|
| Creative gate | After Phase 2 | 🎯 Critic | Concept is original, on-brief, executable |
| Script gate | After Phase 3 | 🔍 Reviewer | Timing fits, TTS-readable, platform-appropriate |
| Draft gate | After video generation | 🎯 Critic | IMPACT ≥ 20/30 |
| Final gate | Before delivery | 🔍 Reviewer | Full checklist passes |

## Revision Limits
- Max 2 creative revisions before escalating to user
- Max 2 production redos before escalating to user
- Max 1 script revision
- If stuck in a loop, ask the user for guidance
