---
name: hitpop-character-sheet
description: "Character reference sheet generator — professional 3-view turnaround with color palette and detail callouts. For anime, realistic, or any style. Ensures character consistency across all scenes in short films, dramas, and storytelling content."
version: 0.1.0
metadata:
  openclaw:
    emoji: "🎨"
    requires:
      env:
        - ZHIPU_API_KEY
---

# Hitpop Character Sheet — 3-View Reference Generator

Generate professional character design sheets that ensure visual consistency across all scenes. Every character in a multi-scene production MUST have a sheet before any scene work begins.

## What a Character Sheet Contains

**Layout**: Three-view turnaround on clean grid background (16:9 landscape)
- **Front view** (left): Full body, neutral standing pose, facing camera
- **3/4 view** (center): Full body, slightly turned, showing depth
- **Back view** (right): Full body, rear details (hair, clothing back)

**Detail callouts**: 5-6 circular zoom-in bubbles with connecting lines:
- Hair (texture, style, color, accessories)
- Face (eyes, expression, unique features)
- Clothing top (collar, pockets, fabric, logos)
- Clothing bottom (type, color, fit)
- Footwear (type, color, details)
- Accessories (ties, belts, bags, jewelry)

**Color palette**: 3-5 swatches at top with labels (main, secondary, accent 1-3)

**Title**: Character name at top

**Background**: Clean — grid, lined paper, or solid pastel. Never a scene background.

## Prompt Template: Anime/Cartoon Style

```
Character design sheet, professional character turnaround reference, [CHARACTER_DESCRIPTION].

Layout: three views side by side on light pink grid background — front view (left), three-quarter view (center), back view (right). Full body, standing neutral pose, white/clean ground plane.

Top: character name title "[NAME]" in bold, color palette showing [N] swatches with labels (main: [COLOR], secondary: [COLOR], accent 1: [COLOR], accent 2: [COLOR], accent 3: [COLOR]).

Detail callouts: circular zoom-in bubbles with thin connecting lines pointing to key features:
- [FEATURE 1]: [detail]
- [FEATURE 2]: [detail]
- [FEATURE 3]: [detail]
- [FEATURE 4]: [detail]
- [FEATURE 5]: [detail]
- [FEATURE 6]: [detail]

Style: [anime/cartoon/chibi], clean line art, flat color with soft shading, professional character design sheet, game art style, high detail, consistent proportions across all three views.

Aspect ratio: 16:9 landscape, high resolution.
```

## Prompt Template: Realistic/Semi-Realistic Style

```
Professional character reference sheet, photorealistic turnaround, [CHARACTER_DESCRIPTION].

Layout: three views side by side on neutral studio background — front view (left), three-quarter view (center), back view (right). Full body, standing neutral pose, studio lighting.

Top: character label "[NAME]", color palette strip showing key colors with hex values (skin: [HEX], hair: [HEX], clothing primary: [HEX], clothing secondary: [HEX], accent: [HEX]).

Detail callouts: circular magnification bubbles with thin lines to:
- Hair: [exact style, length, texture, color, parting]
- Face: [age, skin tone, eye color, expression]
- Upper clothing: [type, color, material, collar, sleeves, pockets, logos]
- Lower clothing: [type, color, fit, length]
- Footwear: [type, color, details]
- Accessories: [each item with exact description]

Style: semi-realistic digital art, professional concept art, character design sheet for production, consistent lighting and proportions across all views, clean background.

Aspect ratio: 16:9 landscape, high resolution.
```

## Example: Convenience Store Drama

**Lin Xiao (protagonist):**
```
Character design sheet, professional character turnaround reference, young Chinese woman convenience store worker.

Layout: three views side by side on light cream grid background — front view (left), three-quarter view (center), back view (right). Full body, standing neutral pose.

Top: character name "Lin Xiao" in bold, color palette: main (#FFB5A7 skin), secondary (#4A90D9 blue uniform), accent 1 (#FFFFFF white collar), accent 2 (#2C2C2C black hair), accent 3 (#F5F5DC beige apron).

Detail callouts:
- HAIR: short black bob cut, straight, just above shoulders, side-parted bangs
- NAME TAG: white rectangular tag on left chest, "Lin Xiao" text
- UNIFORM: blue short-sleeve polo shirt, white collar trim, two chest pockets
- APRON: beige waist apron tied at back, two front pockets
- PANTS: dark navy straight-leg work pants, ankle length
- SHOES: white canvas sneakers

Style: anime illustration, clean line art, soft cel shading, warm color palette, professional character sheet, consistent proportions across all three views.

Aspect ratio: 16:9 landscape, 2K resolution.
```

## After Approval: Extract CHARACTER Block

Once the user approves the character sheet, extract this block and paste IDENTICALLY into every scene prompt:

```
[CHARACTER: {name}, {gender}, age ~{X}, HAIR: {exact style} {color}, CLOTHING: {exact items with colors}, SHOES: {type and color}, ACCESSORIES: {items}, DISTINGUISHING: {unique features}]
```

This block is copied IDENTICALLY. No paraphrasing. No shortening.

## Critical Rules

1. **16:9 landscape** — portrait cuts off the layout
2. **Three views** — a single portrait is NOT a character sheet
3. **Color palette swatches** — ensures color consistency
4. **Detail callouts** — at least 5-6 zoom bubbles
5. **Clean background** — never a scene background
6. **User approval required** before any scene work
7. **One sheet per character** — 3 characters = 3 sheets
8. **Save the exact prompt** — reuse verbatim for regeneration
