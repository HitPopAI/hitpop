---
name: hitpop-character-realistic
description: "Photorealistic character reference sheet generator — single-image 3-view turnaround with color palette, detail callouts, 7-dimension prompt engineering, and common-sense checks. For photorealistic, cinematic, Korean drama, and semi-realistic styles. Also generates single portrait photos for virtual idol lip sync use."
version: 0.1.0
metadata:
  openclaw:
    emoji: "📸"
    requires:
      env:
        - ZHIPU_API_KEY
---

# Hitpop Character Sheet — Photorealistic Style

Generate professional photorealistic character design sheets as a SINGLE IMAGE containing three views. Also supports generating single portrait photos for virtual idol singing videos (lip sync input).

**CRITICAL RULE: For 3-view sheets, always generate three views in ONE image. Never generate three separate images.**

## Two Output Modes

### Mode A: 3-View Reference Sheet (for short films, dramas, ads)
Three full-body views side by side in one 16:9 landscape image. Used when you need the character to appear in multiple scenes and must maintain consistency.

### Mode B: Single Portrait Photo (for virtual idol / lip sync videos)
One high-quality portrait photo (upper body or full body) in 9:16 vertical format. Used as input for TopView Avatar 4 / HeyGen lip sync. The same portrait is reused for every video to maintain idol identity.

**Ask user which mode they need if unclear.**

## 7-Dimension Prompt Checklist

Every character prompt MUST cover all 7 dimensions. Check each before generating:

### 1. Style (风格)
| Content Type | Style Keywords |
|---|---|
| Modern realistic | `photorealistic, cinematic quality, natural skin texture, 8K detail, shot on Canon EOS R5` |
| Chinese historical drama | `photorealistic Chinese historical drama, cinematic quality, traditional costume, period lighting` |
| Korean drama aesthetic | `Korean drama aesthetic, soft romantic lighting, clean skin, natural beauty` |
| Virtual idol / singer | `photorealistic portrait photo, studio lighting, music performance, concert atmosphere` |
| Fashion / commercial | `commercial photography, editorial lighting, high fashion, clean background` |

### 2. Perspective (视角)
- Mode A (3-view): `three full-body views arranged horizontally: Left front view, Center 3/4 view, Right back view`
- Mode B (portrait): `upper body portrait facing camera` or `full body standing` depending on use case

### 3. Subject (主体) — BE EXTREMELY SPECIFIC
- Gender + age + ethnicity + build + height
- Face: face shape, skin tone (specific — "fair warm" not just "fair"), eye color and shape, eyebrow shape, nose shape, lip shape and color, expression
- Hair: exact color name (not just "brown" — use "dark chestnut brown" or "platinum blonde"), exact length (to shoulders/to waist/above ears), exact style (straight/wavy/curly/braided), parting (center/side/none), texture (silky/matte/voluminous), any hair accessories
- Upper clothing: garment type, specific color name + hex code, material/fabric (cotton/leather/silk/denim), collar style, sleeve type, pockets, logos/patches, buttons/zippers, layering
- Lower clothing: garment type, color, fit (slim/straight/wide/flared), length
- Footwear: type, color, details (laces, heels, soles, buckles)
- Accessories: every single item — bags, belts, jewelry (earrings/necklace/rings/bracelets), hats, watches, scarves, gloves, glasses

### 4. Background (背景)
- Mode A (3-view): `clean white studio background` — never a scene background
- Mode B (portrait): can include contextual background (stage, room, street) to set mood — but keep it slightly blurred (bokeh) so the character remains the focus

### 5. Details (细节)
- Tattoos, scars, moles, freckles, piercings
- Makeup details (eyeliner, eyeshadow color, lip color, blush)
- Nail polish color
- Fabric texture (leather grain, denim weave, silk sheen)
- Jewelry details (gem color, chain thickness, ring design)

### 6. Lighting (光影)
- Mode A (3-view): `consistent even studio lighting, soft fill light, no harsh shadows, same lighting across all three views`
- Mode B (portrait): match the intended context — `moody purple stage lighting` for performer, `warm golden hour` for romantic, `clean studio lighting` for commercial

### 7. Quality (质量词)
- Always include: `4K, high quality, photorealistic, masterpiece, best quality, natural skin texture, 8K detail, professional character model sheet for film production`
- For portraits: add `shot on Canon EOS R5, 85mm f/1.4, shallow depth of field` for that professional photo look

## Common-Sense Checks (MANDATORY before generating)

- **Ethnicity consistency**: East Asian characters → black/dark brown eyes, black/dark brown hair (unless script specifies dyed/colored hair)
- **Era consistency**: Historical characters → period-accurate clothing, hairstyles, accessories. No modern items.
- **Style consistency**: All characters in the same project must use the same level of realism
- **Clothing logic**: Office worker → business casual or formal; singer on stage → performance outfit; student → school uniform or casual wear
- **Age logic**: A 50-year-old man should have age-appropriate features (wrinkles, grey hair if specified). A 7-year-old should look like a child.
- **Skin texture**: Photorealistic means visible pores, natural skin imperfections, not airbrushed perfection. Include `natural skin texture` in prompt.

## Prompt Template: Mode A — 3-View Reference Sheet

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

## Prompt Template: Mode B — Virtual Idol Portrait (for lip sync)

```
Photorealistic portrait photo of [CHARACTER_DESCRIPTION].

[gender], [age], [ethnicity]. [Face details: face shape, skin tone, eye color, eyebrows, nose, lips, expression]. [Hair: exact color, length, style, parting]. [Clothing: exact description with colors]. [Accessories: every item].

[SCENE/CONTEXT]: [e.g. "standing at microphone on stage", "sitting with acoustic guitar in bedroom", "in recording studio with headphones around neck"]

[CAMERA]: [e.g. "medium close-up, eye level", "upper body, slight low angle", "full body standing"]

[LIGHTING]: [e.g. "moody purple and blue stage spotlights, bokeh lights in background", "warm bedroom lamp light, soft shadows", "clean studio ring light"]

Style: photorealistic, shot on Canon EOS R5, 85mm f/1.4, shallow depth of field, natural skin texture, 8K detail, cinematic color grading.

Aspect ratio: 9:16 vertical (1080x1920) for Douyin/TikTok.
```

## Example: Mode A — Late Night Drama Characters

**Girl at bus stop (Xiao Lin, 22 years old, office worker):**
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

## Example: Mode B — Virtual Idol Portrait

**Song Juhan (male rocker, virtual idol):**
```
Photorealistic portrait photo of a 22-year-old Chinese male singer performing on stage.

Male, age 22, Chinese. Sharp jawline, high cheekbones, fair clean skin with natural texture, intense dark brown narrow eyes with slight eyeliner, strong straight eyebrows, straight nose, thin lips slightly parted while singing, fierce concentrated expression. Platinum blonde long messy hair past shoulders, side-swept bangs covering right eye partially, slightly damp from sweat.

Wearing black leather biker jacket (#1A1A1A) unzipped over black mesh see-through top, silver chunky chain choker necklace, multiple silver rings on both hands (3 on left, 2 on right), black leather wristband on left wrist.

Standing at chrome microphone stand, right hand gripping microphone, left hand on mic stand. Stage background with moody purple and blue spotlights, fog machine haze, Marshall guitar amps blurred in background, bokeh concert lights.

Camera: medium close-up from chest up, slight low angle (looking up at performer), eye contact with camera.

Lighting: dramatic purple (#6B3FA0) key light from upper left, blue (#1E3A5F) fill light from right, white backlight rim on hair, strong contrast, concert atmosphere.

Style: photorealistic, shot on Canon EOS R5, 85mm f/1.4, shallow depth of field, natural skin texture with visible pores and sweat, 8K detail, cinematic color grading, concert photography feel.

Aspect ratio: 9:16 vertical (1080x1920) for Douyin/TikTok.
```

**Lin Xi (female ballad singer, virtual idol):**
```
Photorealistic portrait photo of a 20-year-old Chinese female singer in a cozy bedroom setting.

Female, age 20, Chinese. Round soft face, fair porcelain skin with light natural blush, large bright dark brown eyes with double eyelids, soft arched eyebrows, small button nose, full soft pink lips with slight smile while singing, sweet and dreamy expression. Dark chestnut brown long straight hair to mid-back, center-parted, silky texture, no accessories.

Wearing oversized cream-white knit sweater (#FFF8E7) with loose collar showing left shoulder slightly, sleeves covering half of hands. Light blue denim shorts barely visible. Sitting cross-legged on bed, holding acoustic guitar (#8B6914 natural wood color) with left hand on fretboard, right hand strumming.

Bedroom background: warm-toned wooden bookshelf with fairy lights (bokeh), soft bedding, warm table lamp glow, cozy atmosphere.

Camera: medium shot from waist up, eye level, centered composition, slight head tilt to right.

Lighting: warm golden (#FFD700) table lamp from right side, soft ambient fill from fairy lights, warm color temperature, cozy intimate atmosphere.

Style: photorealistic, shot on Canon EOS R5, 50mm f/1.8, medium depth of field, natural skin texture, 8K detail, warm cinematic color grading, indie music video aesthetic.

Aspect ratio: 9:16 vertical (1080x1920) for Douyin/TikTok.
```

## After Approval: Extract CHARACTER Block

Once user approves the character sheet or portrait, extract this block and paste IDENTICALLY into every subsequent prompt:

```
[CHARACTER: {name}, {gender}, {ethnicity}, age ~{X}, HAIR: {exact style, color, length from approved image}, FACE: {skin tone, eye color, face shape, expression style}, CLOTHING: {exact items with specific colors and hex codes}, SHOES: {type and color}, ACCESSORIES: {every item}, DISTINGUISHING: {unique features — scars, tattoos, piercings, etc.}]
```

This block is copied IDENTICALLY into every scene. No paraphrasing. No shortening. No "simplifying."

## Generation Settings

- **Model**: `doubao-seedream-4.5`
- **Size**: `2K` for 3-view sheets (16:9), `1080x1920` for vertical portraits (9:16)
- **Watermark**: `false`
- **API endpoint**: `https://open.bigmodel.cn/api/paas/v4/images/generations`

```bash
# 3-View Sheet (16:9 landscape)
curl -s -X POST 'https://open.bigmodel.cn/api/paas/v4/images/generations' \
  -H "Authorization: Bearer $ZHIPU_API_KEY" \
  -H 'Content-Type: application/json' \
  -d '{
    "model": "doubao-seedream-4.5",
    "prompt": "YOUR_3VIEW_PROMPT_HERE",
    "size": "2K",
    "watermark": false
  }'

# Portrait (9:16 vertical for Douyin)
curl -s -X POST 'https://open.bigmodel.cn/api/paas/v4/images/generations' \
  -H "Authorization: Bearer $ZHIPU_API_KEY" \
  -H 'Content-Type: application/json' \
  -d '{
    "model": "doubao-seedream-4.5",
    "prompt": "YOUR_PORTRAIT_PROMPT_HERE",
    "size": "1080x1920",
    "watermark": false
  }'
```

## Critical Rules

1. **Ask mode first** — if user didn't specify, ask: "需要三视图角色设定图（用于短剧/广告）还是单人肖像照（用于虚拟偶像翻唱视频）？"
2. **Mode A: ONE image, three views** — never generate three separate images
3. **Mode A: 16:9 landscape** — portrait orientation cuts off the three-view layout
4. **Mode B: 9:16 vertical** — for Douyin/TikTok, always generate in vertical format
5. **CRITICAL consistency line** — for Mode A, always include all 5 consistency rules in the prompt
6. **7-dimension check** — verify all 7 dimensions are covered before generating
7. **Common-sense check** — ethnicity, era, style, clothing logic, age logic, skin texture
8. **Color palette with hex values** — for Mode A, place at top of image
9. **Detail callouts** — for Mode A, at least 5-6 circular zoom bubbles
10. **English prompts** — always write the generation prompt in English for better AI results
11. **User approval required** — show the result and wait for user confirmation before any scene work or lip sync
12. **Save the portrait for reuse** — for virtual idols, the SAME portrait photo must be used for every lip sync video to maintain idol identity. Download and save locally immediately.
13. **Natural skin texture** — photorealistic means visible pores, natural imperfections, not airbrushed. Always include `natural skin texture` in prompt.
