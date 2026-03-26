---
name: hitpop-character-sheet
description: "Character reference sheet generator — single-image 3-view turnaround with color palette, detail callouts, 7-dimension prompt engineering, and common-sense checks. Supports anime, realistic, and semi-realistic styles."
version: 0.2.0
metadata:
  openclaw:
    emoji: "🎨"
    requires:
      env:
        - ZHIPU_API_KEY
---

# Hitpop Character Sheet — 3-View Reference Generator

Generate professional character design sheets as a SINGLE IMAGE containing three views. This ensures visual consistency across all scenes.

**CRITICAL RULE: Always generate three views in ONE image. Never generate three separate images.**

## What a Character Sheet Contains

**Layout**: Three full-body views of the SAME character, side by side (16:9 landscape)
- **Left**: Front view — facing camera, neutral standing pose
- **Center**: 3/4 view or side profile — showing depth and volume
- **Right**: Back view — rear details (hair back, clothing back)

**Color palette**: 3-5 swatches at top with labels and hex values

**Detail callouts**: 5-6 circular zoom-in bubbles with connecting lines

**Background**: Clean white or light grid. Never a scene background.

**CRITICAL**: All three views must show the EXACT SAME person with identical face, hair, clothing, accessories, and body proportions.

## 7-Dimension Prompt Checklist

Every character sheet prompt MUST cover all 7 dimensions. Check each before generating:

### 1. Style (风格)
| Content Type | Style Keywords |
|---|---|
| Modern realistic | `photorealistic, cinematic quality, natural skin texture, 8K detail` |
| Chinese historical | `Chinese historical drama, photorealistic, cinematic quality` |
| Korean drama | `Korean drama aesthetic, soft lighting, romantic` |
| Anime | `anime style, cel shading, vibrant colors, clean line art` |
| Cartoon | `cartoon style, bold colors, simplified features` |
| Fantasy | `fantasy art, magical atmosphere, ethereal` |

### 2. Perspective (视角)
Fixed: `three full-body views arranged horizontally: Left front view, Center 3/4 view, Right back view`

### 3. Subject (主体) — BE EXTREMELY SPECIFIC
- Gender + age + ethnicity + build
- Hair: exact color, length, style, parting, texture, accessories
- Face: shape, skin tone, eye color, eyebrow shape, expression
- Clothing: type, color (specific — "emerald green" not "green"), fabric, pattern, details
- Shoes: type, color, details
- Accessories: every item with exact description

### 4. Background (背景)
- Character sheets: `clean white background` or `light grid background`
- Scene images: specific environment (handled by hitpop-scene-guide)

### 5. Details (细节)
- Accessories, weapons, props
- Patterns, embroidery, logos on clothing
- Hair accessories, crowns, belts, jewelry

### 6. Lighting (光影)
- Character sheets: `consistent even studio lighting, soft fill light, no harsh shadows`
- Ensures all three views look like the same lighting setup

### 7. Quality (质量词)
- Realistic: `4K, high quality, photorealistic, masterpiece, best quality, professional character model sheet for film production`
- Anime: `high quality, professional character design sheet, game art style, high detail`

## Common-Sense Checks (MANDATORY before generating)

- **Ethnicity consistency**: East Asian characters → black/dark brown eyes, black/dark brown hair (unless script specifies otherwise)
- **Era consistency**: Historical characters → no modern elements (no sneakers on ancient warriors)
- **Style consistency**: All characters in same project must use same art style
- **Clothing logic**: Martial arts characters → clothes allow movement; bride → wedding accessories
- **Age logic**: A 7-year-old child should look like a child, not a small adult

## Prompt Template: Realistic / Photorealistic

```
Professional character design model sheet. ONE character shown from exactly THREE angles in a single image.

Left: Front view (facing camera) | Center: Three-quarter view (turned 45 degrees) | Right: Back view (facing away)

All three views on clean white studio background. Full body, standing neutral pose. All three views must be the SAME height and aligned at the feet.

Character: [gender], [age], [ethnicity], [build], [height].
Face: [face shape], [skin tone], [eye color and shape], [eyebrow shape], [nose], [lip shape and color], [expression].
Hair: [exact color name], [exact length], [exact style], [parting], [texture], [any hair accessories].
Upper body: [garment type], [specific color name + hex], [material/fabric], [collar style], [sleeve type], [pockets], [logos/patches], [buttons/zippers].
Lower body: [garment type], [color], [fit], [length].
Footwear: [type], [color], [details].
Accessories: [every item — bags, belts, jewelry, hats, watches, etc.]

CRITICAL CONSISTENCY RULES (the AI model MUST follow these):
- The face in all three views must be the SAME person — same bone structure, same eyes, same nose, same mouth, same skin tone. NOT three different people.
- The hair must be IDENTICAL in all views — same color, same length, same style, same parting. Only the angle changes.
- The clothing must be PIXEL-IDENTICAL in all views — same colors, same fabric, same wrinkles, same details. Only the visible side changes.
- The body proportions must be IDENTICAL — same height, same build, same limb length.
- DO NOT generate three different people. This is ONE person photographed from three camera angles in the same studio session.

Color palette at top: [main color + hex], [secondary + hex], [accent 1 + hex], [accent 2 + hex], [accent 3 + hex].

Detail callouts: circular magnification bubbles with thin lines pointing to:
- HAIR: [key detail]
- FACE: [key detail]
- UPPER: [key detail]
- LOWER: [key detail]
- SHOES: [key detail]
- ACCESSORY: [key detail]

Style: photorealistic, cinematic quality, natural skin texture, 8K detail, professional character model sheet for film production, consistent studio lighting across all three views, clean white background, SAME person in all views, uniform lighting and color grading.

Aspect ratio: 16:9 landscape, high resolution, 2K.
```

## Prompt Template: Anime / Cartoon

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

## Example: Realistic — Late Night Drama

**Girl at bus stop (22 years old, office worker):**
```
Character design reference sheet, three full-body views of the SAME character on clean white background.

Left: Front view | Center: Three-quarter view | Right: Back view

[SUBJECT]: Chinese female, age 22, slender build, 165cm. [FACE]: oval face, fair warm skin tone, dark brown almond-shaped eyes, thin natural eyebrows, small straight nose, soft pink lips, tired but gentle expression. [HAIR]: black, shoulder-length, slightly wavy, center-parted, tucked behind left ear, no accessories. [UPPER CLOTHING]: light grey oversized knit cardigan over white crew-neck t-shirt, cardigan unbuttoned, sleeves slightly pushed up. [LOWER CLOTHING]: dark navy straight-leg jeans, ankle-length, slightly worn. [FOOTWEAR]: white canvas sneakers, slightly dirty from walking. [ACCESSORIES]: small black crossbody bag on right hip, thin silver chain necklace, no rings.

CRITICAL: All three views must show the EXACT SAME person with identical face, hair, clothing, accessories, and body proportions. No variation between views.

Color palette at top: skin (#F5D0B0), hair (#1A1A1A), cardigan (#C0C0C0), jeans (#2C3E50), sneakers (#FFFFFF).

Detail callouts:
- HAIR: center-parted, shoulder-length, slightly wavy, tucked behind left ear
- FACE: tired gentle expression, dark brown eyes, no makeup
- CARDIGAN: oversized grey knit, unbuttoned, relaxed fit
- JEANS: dark navy straight-leg, ankle crop
- SHOES: white canvas sneakers, slightly worn
- BAG: small black crossbody, minimal design

Style: photorealistic, cinematic quality, natural skin texture, 8K detail, professional character model sheet for film production, consistent studio lighting across all three views, clean white background.

Aspect ratio: 16:9 landscape, high resolution.
```

## Example: Anime — Convenience Store Drama

**Lin Xiao (protagonist):**
```
Character design sheet, professional character turnaround reference, young Chinese woman convenience store worker.

Left: Front view | Center: Three-quarter view | Right: Back view

Three full-body views of the SAME character on light cream grid background. Standing neutral pose.

[SUBJECT]: female, age 22, warm and gentle personality. [HAIR]: black, short bob cut, straight, just above shoulders, side-parted bangs. [CLOTHING]: blue short-sleeve polo shirt with white collar trim, two chest pockets with button flaps, white rectangular name tag "Lin Xiao" on left chest, beige waist apron tied at back with two front pockets, dark navy straight-leg work pants ankle length. [SHOES]: white canvas sneakers, clean. [ACCESSORIES]: none.

CRITICAL: All three views must show the EXACT SAME character with identical hair, clothing, colors, and proportions.

Top: character name "Lin Xiao" in bold, color palette: skin (#FFB5A7), uniform (#4A90D9), collar (#FFFFFF), hair (#2C2C2C), apron (#F5F5DC).

Detail callouts:
- HAIR: short black bob, side-parted bangs
- NAME TAG: white tag on left chest, "Lin Xiao"
- UNIFORM: blue polo, white collar trim, two pockets
- APRON: beige waist apron, tied at back
- PANTS: dark navy straight-leg
- SHOES: white canvas sneakers

Style: anime illustration, clean line art, soft cel shading, warm color palette, professional character sheet, consistent proportions across all three views.

Aspect ratio: 16:9 landscape, 2K resolution.
```

## After Approval: Extract CHARACTER Block

Once user approves, extract this and paste IDENTICALLY into every scene prompt:

```
[CHARACTER: {name}, {gender}, {ethnicity}, age ~{X}, HAIR: {exact style and color}, FACE: {skin tone, eye color, expression style}, CLOTHING: {exact items with specific colors}, SHOES: {type and color}, ACCESSORIES: {items}, DISTINGUISHING: {unique features}]
```

This block is copied IDENTICALLY into every scene. No paraphrasing. No shortening.

## Critical Rules

1. **ONE image, three views** — never generate three separate images
2. **Ask style first** — if user didn't specify "写实/realistic" or "动漫/anime", ASK before generating: "请问您想要写实真人风格还是动漫风格？" Never assume.
3. **16:9 landscape** — portrait cuts off the layout
3. **CRITICAL line** — always include the "EXACT SAME person" enforcement line
4. **7-dimension check** — verify all 7 dimensions before generating
5. **Common-sense check** — ethnicity, era, style, clothing logic, age logic
6. **Color palette with hex values** — ensures color consistency across scenes
7. **Detail callouts** — at least 5-6 zoom bubbles for key features
8. **Clean background** — white or light grid, never a scene
9. **English prompts** — always write prompts in English for better AI results
10. **User approval required** — show sheet and wait for confirmation before any scene work
11. **One sheet per character** — 3 characters = 3 sheets
12. **Save the exact prompt** — reuse verbatim for regeneration if needed
