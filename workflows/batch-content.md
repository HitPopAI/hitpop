# 📦 Batch Social Content Workflow

Generate multiple video variations from templates for social media campaigns.

## When to Use
- User needs 5-20 videos with same layout but different content
- E-commerce product videos from a catalog
- Multi-language versions of the same video
- A/B testing different hooks/CTAs

## Phases

### Phase 1: Template Design
```
🧠 Planner → 💡 Creative: "design a reusable template"
💡 Creative → template spec (layout, animations, variable slots)
🧠 Planner → 🎯 Critic: "review template quality"
```

### Phase 2: Content Variations
```
🧠 Planner → ✍️ Writer: "write copy for N variations"
✍️ Writer → returns array of {title, description, narration, hashtags}
```

### Phase 3: Batch Production
```
🧠 Planner → 💻 Producer: "batch render all variations"
💻 Producer:
  - Uses Rendervid or JSON2Video for template rendering
  - Generates TTS for each variation
  - Merges audio + video for each
  - Exports all for target platform
```

### Phase 4: Spot Check
```
🧠 Planner → 🎯 Critic: "spot-check 3 random outputs"
🎯 Critic → PASS or REDO (if systematic issue, redo all)
```

### Phase 5: Delivery
```
🔍 Reviewer → batch approval
🎬 Main → user: all videos + download links
```
