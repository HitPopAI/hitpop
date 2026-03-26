---
name: hitpop-consistency-check
description: "Visual consistency verification tool using GLM-4.6V. Compares scene images and video frames against character reference sheets. Catches style mismatches, face changes, clothing differences BEFORE they reach the user. Must be called after every scene generation."
version: 0.1.0
metadata:
  openclaw:
    emoji: "🔍"
    requires:
      env:
        - ZHIPU_API_KEY
      bins:
        - curl
        - ffmpeg
---

# Hitpop Consistency Check — Automated Visual Verification

This skill is NOT optional. It MUST be called after every scene image and every video clip that contains a character. Skipping this check is the #1 cause of user rejection.

## When to Use

| After generating... | Check against... |
|---|---|
| Character sheet | Itself — verify it has 3 views, color palette, callouts |
| Scene image | Character reference sheet |
| Video clip | Character reference sheet (extract frame first) |
| Product ad frame | Product reference sheet |

## Check 1: Character Sheet Format Validation

Run this IMMEDIATELY after generating a character sheet, BEFORE showing to user:

```bash
curl -s -X POST 'https://open.bigmodel.cn/api/paas/v4/chat/completions' \
  -H "Authorization: Bearer $ZHIPU_API_KEY" \
  -H 'Content-Type: application/json' \
  -d '{
    "model": "glm-4.6v",
    "messages": [{"role":"user","content":[
      {"type":"image_url","image_url":{"url":"CHARACTER_SHEET_URL"}},
      {"type":"text","text":"Analyze this image. Answer each question with YES or NO:\n1. Does it show exactly 3 full-body views of a character (front, side/3-quarter, back)?\n2. Are all 3 views showing the SAME character (same face, hair, clothing)?\n3. Is there a color palette with color swatches at the top?\n4. Are there detail callout bubbles pointing to specific features?\n5. Is the aspect ratio landscape (wider than tall)?\n6. Are all views full-body (head to feet visible)?\n\nThen give overall verdict: VALID or INVALID with reason."}
    ]}]
  }'
```

**VALID** → show to user for approval
**INVALID** → regenerate, DO NOT show to user

## Check 2: Scene Image vs Character Sheet

Run this after EVERY scene image generation:

```bash
curl -s -X POST 'https://open.bigmodel.cn/api/paas/v4/chat/completions' \
  -H "Authorization: Bearer $ZHIPU_API_KEY" \
  -H 'Content-Type: application/json' \
  -d '{
    "model": "glm-4.6v",
    "messages": [{"role":"user","content":[
      {"type":"image_url","image_url":{"url":"CHARACTER_SHEET_URL"}},
      {"type":"image_url","image_url":{"url":"SCENE_IMAGE_URL"}},
      {"type":"text","text":"Image 1 is a character reference sheet. Image 2 is a scene image that should contain the same character. Score each dimension as PASS or FAIL:\n\n1. ART STYLE — same illustration/art style? (FAIL = one anime, other realistic)\n2. HAIR — same color, length, style? (FAIL = any visible difference)\n3. FACE — same face shape, features? (FAIL = looks like different person)\n4. UPPER CLOTHING — same garment type and color? (FAIL = different clothes or color)\n5. LOWER CLOTHING — same type and color? (FAIL = different pants/skirt or color)\n6. BODY TYPE — same build? (FAIL = slim became stocky)\n\nAllowed to differ: expression, pose, background, lighting, camera angle.\n\nOutput:\nSTYLE: PASS/FAIL\nHAIR: PASS/FAIL\nFACE: PASS/FAIL\nUPPER: PASS/FAIL\nLOWER: PASS/FAIL\nBODY: PASS/FAIL\nVERDICT: CONSISTENT or INCONSISTENT\nREASON: specific differences if inconsistent"}
    ]}]
  }'
```

**Verdict rules:**
- Any FAIL in STYLE, HAIR, FACE, or UPPER → **REJECT** (regenerate)
- 1 minor FAIL (LOWER, BODY) → **WARNING** (acceptable in some cases)
- 2+ FAIL → **REJECT**
- All PASS → **PROCEED**

## Check 3: Video Frame vs Character Sheet

Run this after EVERY video clip generation:

```bash
# Step 1: Extract a frame from the video (2 seconds in)
ffmpeg -ss 2 -i scene_clip.mp4 -frames:v 1 -q:v 2 frame_check.jpg

# Step 2: Upload frame and compare (same API call as Check 2, but with video frame)
curl -s -X POST 'https://open.bigmodel.cn/api/paas/v4/chat/completions' \
  -H "Authorization: Bearer $ZHIPU_API_KEY" \
  -H 'Content-Type: application/json' \
  -d '{
    "model": "glm-4.6v",
    "messages": [{"role":"user","content":[
      {"type":"image_url","image_url":{"url":"CHARACTER_SHEET_URL"}},
      {"type":"image_url","image_url":{"url":"FRAME_CHECK_URL"}},
      {"type":"text","text":"Image 1 is a character reference sheet. Image 2 is a frame from a video that should show the same character. Is the character in the video frame visually consistent with the reference sheet? Check hair, face, clothing, body type. Answer CONSISTENT or INCONSISTENT with specific differences."}
    ]}]
  }'
```

## Check 4: Product Accuracy

```bash
curl -s -X POST 'https://open.bigmodel.cn/api/paas/v4/chat/completions' \
  -H "Authorization: Bearer $ZHIPU_API_KEY" \
  -H 'Content-Type: application/json' \
  -d '{
    "model": "glm-4.6v",
    "messages": [{"role":"user","content":[
      {"type":"image_url","image_url":{"url":"PRODUCT_REFERENCE_URL"}},
      {"type":"image_url","image_url":{"url":"AD_FRAME_URL"}},
      {"type":"text","text":"Image 1 is a product reference sheet. Image 2 is an ad frame. Is the product accurately reproduced? Check: 1) Shape identical? 2) Logo correct? 3) Label text correct? 4) Colors matching? 5) Proportions correct? Answer ACCURATE or INACCURATE with details."}
    ]}]
  }'
```

## Correct Production Flow (THE ONLY ACCEPTABLE ORDER)

```
Step 1: Generate character sheet (Seedream 4.5)
   ↓
Step 2: [CHECK 1] Validate 3-view format → INVALID? Regenerate
   ↓
Step 3: Show to user → User approves
   ↓
Step 4: Generate scene image (Seedream 4.0 with character sheet as `images` param)
   ↓
Step 5: [CHECK 2] Compare scene vs character sheet → INCONSISTENT? Regenerate
   ↓
Step 6: Generate video (img2video from scene image, NOT text2video)
   ↓
Step 7: [CHECK 3] Extract frame, compare vs character sheet → INCONSISTENT? Regenerate
   ↓
Step 8: Post-production (TTS, subtitles, BGM, merge)
```

**VIOLATIONS (any of these = wrong, redo immediately):**
- Generating scene image WITHOUT passing character sheet as `images` parameter
- Using `doubao-seedream-4.5` for scene images (4.5 does NOT support reference images)
- Using `text2video` for character scenes (always use `img2video` from scene image)
- Skipping any CHECK step
- Showing user an INVALID or INCONSISTENT result

## Cost

Each GLM-4.6V check costs ~¥0.01. A typical 3-scene video needs ~6 checks = ¥0.06 total. This is negligible compared to the ¥2-4 wasted on regenerating scenes that the user rejects for inconsistency.

## Rules

1. **Every scene image gets checked** — no exceptions, no batching
2. **Every video clip gets checked** — extract frame at 2 seconds
3. **REJECT means regenerate** — do not show rejected content to user
4. **Max 3 retries** — if still failing after 3 attempts, show all attempts to user and ask
5. **Log every check** — record PASS/FAIL/reason in production log
