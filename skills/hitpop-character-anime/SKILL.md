---
name: hitpop-character-anime
description: "Anime/cartoon character reference sheet generator — single-image 3-view turnaround with color palette, detail callouts, 7-dimension prompt engineering, and common-sense checks. For anime, cartoon, chibi, and semi-realistic illustration styles."
version: 0.1.0
metadata:
  openclaw:
    emoji: "🎨"
    requires:
      env:
        - ZHIPU_API_KEY
---

# Hitpop Character Sheet — Anime/Cartoon Style

Generate professional anime/cartoon character design sheets as a SINGLE IMAGE containing three views. This ensures visual consistency across all scenes in short films, dramas, and storytelling content.

**CRITICAL RULE: Always generate three views in ONE image. Never generate three separate images.**

## What a Character Sheet Contains

**Layout**: Three full-body views of the SAME character, side by side (16:9 landscape)
- **Left**: Front view — facing camera, neutral standing pose
- **Center**: 3/4 view or side profile — showing depth and volume
- **Right**: Back view — rear details (hair back, clothing back)

**Color palette**: 3-5 swatches at top with character name and hex values

**Detail callouts**: 5-6 circular zoom-in bubbles with connecting lines pointing to key features

**Background**: Clean light pink, cream, or blue grid background. Never a scene background.

## 7-Dimension Prompt Checklist

Every character sheet prompt MUST cover all 7 dimensions. Check each before generating:

### 1. Style (风格)
| Content Type | Style Keywords |
|---|---|
| Anime | `anime style, cel shading, vibrant colors, clean line art` |
| Cartoon | `cartoon style, bold colors, simplified features` |
| Chibi | `chibi style, big head small body, cute proportions` |
| Semi-realistic illustration | `semi-realistic illustration, detailed shading, concept art quality` |
| Fantasy anime | `fantasy anime art, magical atmosphere, ethereal lighting` |
| Game art | `game character art, RPG style, detailed equipment rendering` |

### 2. Perspective (视角)
Fixed: `three full-body views arranged horizontally: Left front view, Center 3/4 view, Right back view`

### 3. Subject (主体) — BE EXTREMELY SPECIFIC
- Gender + age + personality vibe
- Hair: exact color name, exact length, exact style, bangs type, hair accessories
- Face: eye color, eye shape (round/almond/sharp), expression, unique facial features
- Clothing: type, exact color with hex code, material, collar, sleeves, pockets, buttons, logos, patterns
- Shoes: type, exact color, details (laces, soles, height)
- Accessories: list every item with exact description (bags, belts, jewelry, hats, weapons)

### 4. Background (背景)
- Always use: `clean [light pink/cream/blue] grid background` or `white background with grid lines`
- Never use a scene/environment background for character sheets

### 5. Details (细节)
- Patterns, embroidery, logos on clothing
- Hair accessories (ribbons, clips, crowns, headbands)
- Weapons, props, tools
- Jewelry (earrings, necklaces, rings, bracelets)
- Belts, buckles, straps, zippers

### 6. Lighting (光影)
- Always use: `consistent even studio lighting, soft fill light, no harsh shadows`
- All three views must have the same lighting direction and intensity

### 7. Quality (质量词)
- Always include: `high quality, professional character design sheet, game art style, high detail, consistent proportions across all three views, uniform line weight`

## Common-Sense Checks (MANDATORY before generating)

- **Ethnicity consistency**: East Asian characters → black/dark brown eyes, black/dark brown hair (unless script specifies otherwise, e.g. dyed hair for a rebellious character)
- **Era consistency**: Historical/ancient characters → no modern elements (no sneakers on ancient warriors, no smartphones in medieval settings)
- **Style consistency**: All characters in the same project MUST use the same art style (don't mix anime and realistic in one project)
- **Clothing logic**: Martial arts characters → clothes allow movement; school student → school uniform; chef → apron and chef hat
- **Age logic**: A 7-year-old child should look like a child (shorter, rounder face, bigger eyes relative to face), not a small adult

## Prompt Template

```
Professional character design model sheet. ONE character shown from exactly THREE angles in a single image.

Left: Front view (facing camera) | Center: Three-quarter view (turned 45 degrees) | Right: Back view (facing away)

All three views on [light pink/cream/blue] grid background. Full body, standing neutral pose, white ground plane. All three views must be the SAME height and aligned at the feet.

Character: [gender], [age], [personality].
Hair: [exact color name], [exact length], [exact style], [bangs type], [hair accessories if any].
Face: [eye color], [eye shape], [expression], [any unique facial features].
Upper body: [garment type], [exact color with hex], [material], [collar], [sleeves], [details like pockets/buttons/logos].
Lower body: [garment type], [exact color], [fit], [length].
Footwear: [type], [exact color], [details].
Accessories: [list every item with exact description].

CRITICAL CONSISTENCY RULES (the AI model MUST follow these):
- The face in all three views must be the SAME person — same eye shape, same eye color, same nose, same mouth, same face shape. NOT three different faces.
- The hair must be IDENTICAL in all views — same color, same length, same style, same bangs. Only the angle changes.
- The clothing must be PIXEL-IDENTICAL in all views — same colors, same patterns, same wrinkles, same details. Only the visible side changes.
- The body proportions must be IDENTICAL — same height, same build, same limb length.
- DO NOT draw three different characters. This is ONE person from three camera angles.

Top: character name "[NAME]" in bold, color palette showing swatches with hex values (main: [COLOR], secondary: [COLOR], accent 1: [COLOR], accent 2: [COLOR], accent 3: [COLOR]).

Detail callouts: circular zoom-in bubbles with thin connecting lines:
- HAIR: [detail]
- FACE: [detail]
- CLOTHING TOP: [detail]
- CLOTHING BOTTOM: [detail]
- SHOES: [detail]
- ACCESSORY: [detail]

Style: [anime/cartoon/semi-realistic] illustration, clean line art, flat color with soft cel shading, professional character model sheet for animation production, game concept art quality, high detail, PERFECTLY consistent proportions and art style across all three views, uniform line weight across all views.

Aspect ratio: 16:9 landscape, high resolution, 2K.
```

## Example: Convenience Store Drama — Lin Xiao

```
Professional character design model sheet. ONE character shown from exactly THREE angles in a single image.

Left: Front view (facing camera) | Center: Three-quarter view (turned 45 degrees) | Right: Back view (facing away)

All three views on light cream grid background. Full body, standing neutral pose, white ground plane. All three views must be the SAME height and aligned at the feet.

Character: female, age 22, warm and gentle personality.
Hair: black, short bob cut, straight, just above shoulders, side-parted bangs, no hair accessories.
Face: dark brown round eyes, soft gentle expression, slight smile, no unique facial features.
Upper body: blue short-sleeve polo shirt with white collar trim (#4A90D9 blue, #FFFFFF white), two chest pockets with button flaps, white rectangular name tag "Lin Xiao" on left chest, beige waist apron (#F5F5DC) tied at back with two front pockets.
Lower body: dark navy straight-leg work pants (#2C2C54), ankle length, simple fit.
Footwear: white canvas sneakers (#FFFFFF), clean, flat sole, white laces.
Accessories: none.

CRITICAL CONSISTENCY RULES (the AI model MUST follow these):
- The face in all three views must be the SAME person — same eye shape, same eye color, same nose, same mouth, same face shape. NOT three different faces.
- The hair must be IDENTICAL in all views — same color, same length, same style, same bangs. Only the angle changes.
- The clothing must be PIXEL-IDENTICAL in all views — same colors, same patterns, same wrinkles, same details. Only the visible side changes.
- The body proportions must be IDENTICAL — same height, same build, same limb length.
- DO NOT draw three different characters. This is ONE person from three camera angles.

Top: character name "Lin Xiao" in bold, color palette showing swatches with hex values (skin: #FFB5A7, uniform: #4A90D9, collar: #FFFFFF, hair: #2C2C2C, apron: #F5F5DC).

Detail callouts: circular zoom-in bubbles with thin connecting lines:
- HAIR: short black bob, side-parted bangs, straight, just above shoulders
- NAME TAG: white rectangular tag on left chest, text "Lin Xiao"
- UNIFORM: blue polo shirt, white collar trim, two chest pockets with button flaps
- APRON: beige waist apron, tied at back, two front pockets
- PANTS: dark navy straight-leg work pants, ankle length
- SHOES: white canvas sneakers, clean, flat sole

Style: anime illustration, clean line art, flat color with soft cel shading, warm color palette, professional character model sheet for animation production, game concept art quality, high detail, PERFECTLY consistent proportions and art style across all three views, uniform line weight across all views.

Aspect ratio: 16:9 landscape, 2K resolution.
```

## Example: Fantasy RPG — Dark Elf Ranger

```
Professional character design model sheet. ONE character shown from exactly THREE angles in a single image.

Left: Front view (facing camera) | Center: Three-quarter view (turned 45 degrees) | Right: Back view (facing away)

All three views on light blue grid background. Full body, standing neutral pose, white ground plane. All three views must be the SAME height and aligned at the feet.

Character: female, age appears 25 (elf), mysterious and agile personality.
Hair: silver-white, very long reaching waist, straight with slight wave at ends, center-parted, no bangs, pointed elf ears visible.
Face: violet-purple narrow eyes, sharp elegant features, calm neutral expression, dark elf skin tone (light grey-purple #B8A9C9).
Upper body: dark forest green leather chest armor (#2D5A27) with silver buckles, sleeveless showing toned arms, brown leather shoulder guard on left shoulder, dark brown leather belt with silver dagger sheath on right hip.
Lower body: dark brown fitted leather pants (#3E2723), tucked into boots, slight wear marks at knees.
Footwear: dark brown leather boots (#4E342E), knee-high, laced up front, flat reinforced sole for stealth.
Accessories: silver circlet on forehead with small green gem, leather quiver on back with arrows visible over right shoulder, wooden longbow held in left hand.

CRITICAL CONSISTENCY RULES (the AI model MUST follow these):
- The face in all three views must be the SAME person — same eye shape, same eye color, same nose, same mouth, same face shape. NOT three different faces.
- The hair must be IDENTICAL in all views — same color, same length, same style, same bangs. Only the angle changes.
- The clothing must be PIXEL-IDENTICAL in all views — same colors, same patterns, same wrinkles, same details. Only the visible side changes.
- The body proportions must be IDENTICAL — same height, same build, same limb length.
- DO NOT draw three different characters. This is ONE person from three camera angles.

Top: character name "Elara" in bold, color palette showing swatches with hex values (skin: #B8A9C9, hair: #E8E8E8, armor: #2D5A27, leather: #3E2723, silver: #C0C0C0).

Detail callouts: circular zoom-in bubbles with thin connecting lines:
- EARS: pointed elf ears, silver-white hair tucked behind
- CIRCLET: silver band with small emerald green gem on forehead
- ARMOR: dark green leather chest piece, silver buckles, sleeveless
- BELT: dark brown leather, silver dagger sheath on right hip
- QUIVER: leather quiver on back, wooden arrows with green fletching
- BOOTS: dark brown knee-high, laced front, flat reinforced sole

Style: fantasy anime illustration, clean line art, detailed cel shading with soft gradients, professional character model sheet for game production, RPG concept art quality, high detail, PERFECTLY consistent proportions and art style across all three views, uniform line weight across all views.

Aspect ratio: 16:9 landscape, 2K resolution.
```

## After Approval: Extract CHARACTER Block

Once user approves the character sheet, extract this block and paste IDENTICALLY into every scene prompt:

```
[CHARACTER: {name}, {gender}, age ~{X}, HAIR: {exact style and color from sheet}, FACE: {eye color, expression style}, CLOTHING: {exact items with specific colors and hex codes}, SHOES: {type and color}, ACCESSORIES: {items}, DISTINGUISHING: {unique features}]
```

This block is copied IDENTICALLY into every scene. No paraphrasing. No shortening. No "simplifying."

## Generation Settings

- **Model**: `doubao-seedream-4.5`
- **Size**: `2K`
- **Watermark**: `false`
- **API endpoint**: `https://open.bigmodel.cn/api/paas/v4/images/generations`

```bash
curl -s -X POST 'https://open.bigmodel.cn/api/paas/v4/images/generations' \
  -H "Authorization: Bearer $ZHIPU_API_KEY" \
  -H 'Content-Type: application/json' \
  -d '{
    "model": "doubao-seedream-4.5",
    "prompt": "YOUR_PROMPT_HERE",
    "size": "2K",
    "watermark": false
  }'
```

## Critical Rules

1. **ONE image, three views** — never generate three separate images
2. **16:9 landscape** — portrait orientation cuts off the three-view layout
3. **CRITICAL consistency line** — always include all 5 consistency rules in the prompt
4. **7-dimension check** — verify all 7 dimensions are covered before generating
5. **Common-sense check** — ethnicity, era, style, clothing logic, age logic
6. **Color palette with hex values** — at top of image, ensures color consistency across scenes
7. **Detail callouts** — at least 5-6 circular zoom bubbles pointing to key features
8. **Clean grid background** — light pink, cream, or blue grid. Never a scene background
9. **English prompts** — always write the generation prompt in English for better AI results
10. **User approval required** — show the sheet and wait for user confirmation before any scene work begins
11. **One sheet per character** — if the story has 3 characters, generate 3 separate sheets
12. **Save the exact prompt** — keep it for regeneration if the user wants adjustments
