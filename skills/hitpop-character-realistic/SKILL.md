---
name: hitpop-character-realistic
description: "Photorealistic 3-view character reference sheet for short films, dramas, and ads. Single-image turnaround with color palette, detail callouts, 7-dimension prompt engineering, and common-sense checks. For photorealistic, cinematic, and Korean drama styles."
version: 0.2.0
metadata:
  openclaw:
    emoji: "📸"
    requires:
      env:
        - ZHIPU_API_KEY
---

# Hitpop Character Sheet — Photorealistic 3-View (Short Films / Dramas / Ads)

Generate professional photorealistic character design sheets as a SINGLE IMAGE containing three full-body views. Used when you need the character to appear in multiple scenes across a short film, drama, or advertisement.

**CRITICAL RULE: Always generate three views in ONE image. Never generate three separate images.**

## 7-Dimension Prompt Checklist

Every character sheet prompt MUST cover all 7 dimensions. Check each before generating:

### 1. Style (风格)
| Content Type | Style Keywords |
|---|---|
| Modern realistic | `photorealistic, cinematic quality, natural skin texture, 8K detail, shot on Canon EOS R5` |
| Chinese historical drama | `photorealistic Chinese historical drama, cinematic quality, traditional costume, period lighting` |
| Korean drama aesthetic | `Korean drama aesthetic, soft romantic lighting, clean skin, natural beauty` |
| Fashion / commercial | `commercial photography, editorial lighting, high fashion, clean background` |

### 2. Perspective (视角)
Fixed: `three full-body views arranged horizontally: Left front view, Center 3/4 view, Right back view`

### 3. Subject (主体) — BE EXTREMELY SPECIFIC
- Gender + age + ethnicity + build + height
- Face: face shape, skin tone (specific — "fair warm" not just "fair"), eye color and shape, eyebrow shape, nose shape, lip shape and color, expression
- Hair: exact color name ("dark chestnut brown" not "brown"), exact length, exact style, parting, texture, hair accessories
- Upper clothing: garment type, specific color name + hex code, material/fabric, collar style, sleeve type, pockets, logos/patches, buttons/zippers, layering
- Lower clothing: garment type, color, fit (slim/straight/wide), length
- Footwear: type, color, details (laces, heels, soles)
- Accessories: every single item — bags, belts, jewelry, hats, watches, scarves, glasses

### 4. Background (背景)
Always use: `clean white studio background` — never a scene background for character sheets

### 5. Details (细节)
- Tattoos, scars, moles, freckles, piercings
- Makeup details (eyeliner, eyeshadow color, lip color, blush)
- Fabric texture (leather grain, denim weave, silk sheen)
- Jewelry details (gem color, chain thickness, ring design)

### 6. Lighting (光影)
Always use: `consistent even studio lighting, soft fill light, no harsh shadows, same lighting across all three views`

### 7. Quality (质量词)
Always include: `4K, high quality, photorealistic, masterpiece, best quality, natural skin texture, 8K detail, professional character model sheet for film production`

## Common-Sense Checks (MANDATORY before generating)

- **Ethnicity consistency**: East Asian characters → black/dark brown eyes, black/dark brown hair (unless script specifies dyed/colored hair)
- **Era consistency**: Historical characters → period-accurate clothing, hairstyles, accessories. No modern items.
- **Style consistency**: All characters in the same project must use the same level of realism
- **Clothing logic**: Office worker → business casual; singer → performance outfit; student → school uniform or casual
- **Age logic**: A 50-year-old should have age-appropriate features. A 7-year-old should look like a child.
- **Skin texture**: Photorealistic means visible pores, natural skin imperfections. Always include `natural skin texture` in prompt.

## Prompt Template

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

## Example: Late Night Drama — Xiao Lin

```
Professional character design model sheet. ONE character shown from exactly THREE angles in a single image.

Left: Front view (facing camera) | Center: Three-quarter view (turned 45 degrees) | Right: Back view (facing away)

All three views on clean white studio background. Full body, standing neutral pose. All three views must be the SAME height and aligned at the feet.

Character: Chinese female, age 22, slender build, 165cm.
Face: oval face, fair warm skin tone, dark brown almond-shaped eyes, thin natural eyebrows, small straight nose, soft pink lips, tired but gentle expression, slight dark circles under eyes, no makeup.
Hair: black, shoulder-length, slightly wavy, center-parted, tucked behind left ear, no accessories.
Upper body: light grey oversized knit cardigan (#C0C0C0) over white crew-neck t-shirt (#FFFFFF), cardigan unbuttoned, sleeves slightly pushed up to forearms.
Lower body: dark navy straight-leg jeans (#2C3E50), ankle-length, slightly worn at knees.
Footwear: white canvas sneakers (#FFFFFF), slightly dirty from walking, white laces, flat rubber sole.
Accessories: small black crossbody bag (#1A1A1A) on right hip with thin strap, thin silver chain necklace, no rings, no watch.

CRITICAL CONSISTENCY RULES (the AI model MUST follow these):
- The face in all three views must be the SAME person — same bone structure, same eyes, same nose, same mouth, same skin tone. NOT three different people.
- The hair must be IDENTICAL in all views — same color, same length, same style, same parting. Only the angle changes.
- The clothing must be PIXEL-IDENTICAL in all views — same colors, same fabric, same wrinkles, same details. Only the visible side changes.
- The body proportions must be IDENTICAL — same height, same build, same limb length.
- DO NOT generate three different people. This is ONE person photographed from three camera angles in the same studio session.

Color palette at top: skin (#F5D0B0), hair (#1A1A1A), cardigan (#C0C0C0), jeans (#2C3E50), sneakers (#FFFFFF).

Detail callouts: circular magnification bubbles with thin lines pointing to:
- HAIR: center-parted, shoulder-length, slightly wavy, tucked behind left ear
- FACE: tired gentle expression, dark brown almond eyes, dark circles, no makeup
- CARDIGAN: oversized grey knit, unbuttoned, sleeves pushed up
- JEANS: dark navy straight-leg, ankle crop, slightly worn at knees
- SHOES: white canvas sneakers, slightly dirty, flat sole
- BAG: small black crossbody, thin strap, minimal design

Style: photorealistic, cinematic quality, natural skin texture, 8K detail, professional character model sheet for film production, consistent studio lighting across all three views, clean white background, SAME person in all views, uniform lighting and color grading.

Aspect ratio: 16:9 landscape, 2K resolution.
```

## After Approval: Extract CHARACTER Block

Once user approves, extract this and paste IDENTICALLY into every scene prompt:

```
[CHARACTER: {name}, {gender}, {ethnicity}, age ~{X}, HAIR: {exact style, color, length}, FACE: {skin tone, eye color, face shape}, CLOTHING: {exact items with colors and hex codes}, SHOES: {type and color}, ACCESSORIES: {every item}, DISTINGUISHING: {unique features}]
```

This block is copied IDENTICALLY. No paraphrasing. No shortening.

## Generation Settings

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
5. **Common-sense check** — ethnicity, era, style, clothing logic, age logic, skin texture
6. **Color palette with hex values** — at top of image
7. **Detail callouts** — at least 5-6 circular zoom bubbles pointing to key features
8. **Clean white background** — never a scene background
9. **English prompts** — always write in English for better AI results
10. **User approval required** — show sheet and wait for confirmation before any scene work
11. **One sheet per character** — 3 characters = 3 sheets
12. **Natural skin texture** — always include `natural skin texture` in prompt
