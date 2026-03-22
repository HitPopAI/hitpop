---
name: hitpop-pipeline
description: "Video production pipeline with mandatory checkpoints and verification loops. Harness Engineering approach: agent decides freely between checkpoints, but checkpoints themselves are non-skippable gates with automated verification."
version: 0.2.0
metadata:
  openclaw:
    emoji: "🔗"
    requires:
      env:
        - ZHIPU_API_KEY
      bins:
        - curl
        - jq
        - ffmpeg
        - python3
    primaryEnv: ZHIPU_API_KEY
---

# Hitpop Pipeline — Checkpoint-Based Video Production

## Core Principle: Harness Engineering

Agent decides HOW to do each step. Pipeline decides WHAT must be verified before moving on. Agent is free between checkpoints. Checkpoints are mandatory gates.

```
[Step] → [CHECKPOINT: verify] → pass → [Next Step]
                                ↓ fail
                          [Retry up to 3x]
                                ↓ still fail
                          [STOP — ask user]
```

## Checkpoints (NON-SKIPPABLE)

These are the mandatory gates. No matter what the agent decides to do between them, it MUST pass through each checkpoint before proceeding.

### Checkpoint 1: Reference Approval
**When**: After generating character sheets or product reference sheets
**Gate**: User must explicitly approve before any scene work
**Fail action**: Regenerate based on user feedback
```
CHECK: Did user say "ok" / "approved" / "continue" / "looks good"?
  YES → proceed to scene generation
  NO → ask what to change, regenerate sheet
```

### Checkpoint 2: Visual Consistency
**When**: After each scene image or video clip is generated (character content only)
**Gate**: GLM-4.6V comparison against reference sheet
**Fail action**: Regenerate (max 3 retries), then stop and ask user
```bash
# Automated check — extract frame and compare
ffmpeg -ss 2 -i scene_clip.mp4 -frames:v 1 -q:v 2 frame_check.jpg

curl -s -X POST 'https://open.bigmodel.cn/api/paas/v4/chat/completions' \
  -H "Authorization: Bearer $ZHIPU_API_KEY" \
  -H 'Content-Type: application/json' \
  -d '{
    "model": "glm-4.6v",
    "messages": [{"role":"user","content":[
      {"type":"image_url","image_url":{"url":"REFERENCE_SHEET_URL"}},
      {"type":"image_url","image_url":{"url":"FRAME_CHECK_URL"}},
      {"type":"text","text":"Compare strictly: 1) Same art style? 2) Same hair style/color? 3) Same clothing type/color? 4) Same age/body type? Answer CONSISTENT or INCONSISTENT with reasons."}
    ]}]
  }'
```
```
CHECK: GLM-4.6V says CONSISTENT?
  YES → proceed
  NO → log failure reason, regenerate with adjusted params
  3 FAILS → STOP, show user all 3 attempts, ask for guidance
```

### Checkpoint 3: Product Accuracy
**When**: After each product ad frame is generated (product content only)
**Gate**: GLM-4.6V comparison against product reference sheet
**Fail action**: Same as Checkpoint 2 but with ZERO tolerance
```
CHECK: Logo correct? Label correct? Colors match? Shape accurate?
  ALL YES → proceed
  ANY NO → reject immediately, regenerate
  For brand content: ONE wrong letter on logo = reject
```

### Checkpoint 4: File Size
**When**: Before sending any file to user via Telegram
**Gate**: File must be <15MB
**Fail action**: Auto-compress with FFmpeg
```bash
FILE_SIZE=$(stat -f%z output.mp4 2>/dev/null || stat -c%s output.mp4)
if [ "$FILE_SIZE" -gt 15728640 ]; then
  DURATION=$(ffprobe -v error -show_entries format=duration -of csv=p=0 output.mp4)
  TARGET_BITRATE=$(echo "12 * 8192 / $DURATION" | bc)k
  ffmpeg -i output.mp4 -b:v $TARGET_BITRATE -c:a aac -b:a 128k compressed.mp4
fi
```
```
CHECK: File < 15MB?
  YES → send
  NO → compress → send compressed version
```

### Checkpoint 5: Download Verification
**When**: After every API generation call returns SUCCESS
**Gate**: File must be downloaded to local disk and size > 0
**Fail action**: Re-download. If URL expired, regenerate.
```
CHECK: Local file exists AND size > 0?
  YES → proceed
  NO → retry download
  URL EXPIRED → regenerate the asset
```

## Pipeline Templates

### Character Short Film Pipeline
```json
{
  "name": "Short Film",
  "checkpoints": ["reference_approval", "visual_consistency", "file_size", "download_verify"],
  "steps": [
    {"id": "characters", "skill": "hitpop-character-sheet", "checkpoint_after": "reference_approval"},
    {"id": "scenes", "skill": "hitpop-scene-guide", "checkpoint_after": "visual_consistency"},
    {"id": "clips", "skill": "hitpop-gen-video", "method": "img2video_only", "checkpoint_after": "visual_consistency"},
    {"id": "voice", "skill": "hitpop-voiceover", "checkpoint_after": "download_verify"},
    {"id": "subs", "skill": "hitpop-subtitle"},
    {"id": "merge", "skill": "hitpop-edit"},
    {"id": "export", "skill": "hitpop-publish", "checkpoint_after": "file_size"}
  ]
}
```

### Product Ad Pipeline
```json
{
  "name": "Product Ad",
  "checkpoints": ["reference_approval", "product_accuracy", "file_size", "download_verify"],
  "steps": [
    {"id": "product_sheet", "skill": "hitpop-product-sheet", "checkpoint_after": "reference_approval"},
    {"id": "ad_scenes", "skill": "hitpop-scene-guide", "checkpoint_after": "product_accuracy"},
    {"id": "clips", "skill": "hitpop-gen-video", "checkpoint_after": "product_accuracy"},
    {"id": "voice", "skill": "hitpop-voiceover", "checkpoint_after": "download_verify"},
    {"id": "merge", "skill": "hitpop-edit"},
    {"id": "export", "skill": "hitpop-publish", "checkpoint_after": "file_size"}
  ]
}
```

### Simple Content Pipeline (no checkpoints except file_size)
```json
{
  "name": "Quick Content",
  "checkpoints": ["file_size", "download_verify"],
  "steps": [
    {"id": "generate", "skill": "hitpop-gen-video"},
    {"id": "voice", "skill": "hitpop-voiceover"},
    {"id": "merge", "skill": "hitpop-edit"},
    {"id": "export", "skill": "hitpop-publish", "checkpoint_after": "file_size"}
  ]
}
```

## Production Log

Every step MUST write a log entry. This is automatic — not optional.

**Log format** (append to `production.log` in workspace):
```
[TIMESTAMP] step=STEP_ID status=SUCCESS|FAIL|RETRY cost=¥X.XX time=Xs file=FILENAME
[TIMESTAMP] checkpoint=CHECKPOINT_NAME result=PASS|FAIL reason=DETAILS
```

**Examples:**
```
[2026-03-22 19:05:12] step=character_sheet status=SUCCESS cost=¥0.25 time=12s file=linxiao_ref.png
[2026-03-22 19:05:24] checkpoint=reference_approval result=PENDING waiting_for_user
[2026-03-22 19:06:01] checkpoint=reference_approval result=PASS user_said="looks good"
[2026-03-22 19:06:15] step=scene_1 status=SUCCESS cost=¥0.20 time=8s file=scene1.png
[2026-03-22 19:06:23] checkpoint=visual_consistency result=PASS score=0.92
[2026-03-22 19:07:01] step=scene_2 status=SUCCESS cost=¥0.20 time=9s file=scene2.png
[2026-03-22 19:07:10] checkpoint=visual_consistency result=FAIL reason="style_mismatch: realistic vs anime"
[2026-03-22 19:07:15] step=scene_2 status=RETRY attempt=2 cost=¥0.20 time=10s file=scene2_v2.png
[2026-03-22 19:07:25] checkpoint=visual_consistency result=PASS score=0.88
[2026-03-22 19:10:45] step=export status=SUCCESS cost=¥0.00 time=3s file=final.mp4
[2026-03-22 19:10:46] checkpoint=file_size result=FAIL size=26.13MB limit=15MB
[2026-03-22 19:10:52] step=compress status=SUCCESS cost=¥0.00 time=6s file=final_compressed.mp4
[2026-03-22 19:10:53] checkpoint=file_size result=PASS size=11.8MB
[2026-03-22 19:10:53] pipeline=COMPLETE total_cost=¥2.45 total_time=5m41s files=8
```

**At the end of every pipeline, send a summary to user:**
```
✅ Pipeline complete!
  Steps: 8/8 successful
  Retries: 1 (scene_2 consistency fail → regenerated)
  Total cost: ¥2.45
  Total time: 5 minutes 41 seconds
  Output files: [list]
```

## Variable References

Use `$step_id.output` to pass data between steps:
- `$characters.output` → file path from character sheet step
- `$voice.output` → audio file from voiceover step

## Design Principles

1. **Agent is free between checkpoints** — choose models, params, prompts autonomously
2. **Checkpoints are gates, not suggestions** — cannot be skipped or overridden
3. **Fail gracefully** — retry, then ask user, never crash silently
4. **Log everything** — every step, every cost, every failure
5. **Pipelines are shareable** — save as JSON, version in git
