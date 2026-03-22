---
name: hitpop-product-sheet
description: "Product reference sheet generator — 5-angle turnaround with detail callouts, style lock, and accuracy verification. For e-commerce listings, product ads, and brand content. Handles user uploads, URLs, brand names, or from-scratch generation."
version: 0.1.0
metadata:
  openclaw:
    emoji: "📦"
    requires:
      env:
        - ZHIPU_API_KEY
---

# Hitpop Product Sheet — Multi-Angle Product Reference

Product advertising has ZERO tolerance for inconsistency. This skill ensures every product frame matches the real product exactly.

## Input Handling

Users provide product info in many ways:

| User provides | Your action |
|---|---|
| **Real product photo** | Use as primary reference. Generate reference sheet based on it. |
| **Multiple photos** (angles) | Use as multi-angle reference. Stitch into sheet. |
| **Product URL / link** | Fetch page, extract product images. Use best photo. |
| **Brand + product name** | Search web for official images. Download best one. |
| **Verbal description only** | Generate from scratch. Get user approval FIRST. |
| **3D model / render** | Use directly as reference. |
| **Logo file only** | Generate product mock-up with logo. Create sheet. |

**CRITICAL**: For real products, AI output must match the REAL product exactly. Not creative interpretation — accurate reproduction.

## Product Reference Sheet

**Layout**: 5 views on pure white background (16:9 landscape)
- **Front view** (center): Label/logo fully visible
- **3/4 view** (left): 45-degree angle, showing depth
- **Side view** (right): Profile, thickness/depth
- **Back view** (bottom-left): Back label, barcode
- **Top-down view** (bottom-right): Cap/lid/top surface

**Detail callouts**: Circular zoom-in bubbles for:
- Logo (position, size, font, color)
- Label text (exact wording, font color, background)
- Material (matte, glossy, metallic, transparent)
- Color hex codes (primary, secondary, accent)
- Unique features (cap shape, handle, embossing)

## Prompt Template: From Scratch

```
Product reference sheet, professional multi-angle product photography turnaround.

Product: {exact product name and type}
Brand: {brand name}

Layout: 5 views on pure white background — front (center), 3/4 angle (left), side profile (right), back (bottom-left), top-down (bottom-right). Clean studio lighting, no shadows on background.

Detail callouts with circular zoom-in bubbles:
- LOGO: {text, font, color, position}
- LABEL: {text content, font color, background color}
- MATERIAL: {surface finish}
- COLOR: Primary {hex}, Secondary {hex}, Accent {hex}
- CAP/LID: {shape, color, material}
- UNIQUE: {distinguishing detail}

Style: Commercial product photography, ultra-sharp focus, pure white background (#FFFFFF), studio three-point lighting, accurate color reproduction.

Aspect ratio: 16:9 landscape, high resolution.
```

## Prompt Template: From Real Photo

```
Product reference sheet, multi-angle turnaround based on the provided product photo.

Reproduce this EXACT product from 5 angles: front, 3/4, side, back, top-down. Match EXACTLY:
- Label text, font, and positioning
- Logo color, size, and placement
- Product shape, proportions, and dimensions
- Material finish and surface texture
- Color tones from the photo, not approximations

Pure white background, studio lighting, consistent across all 5 views.
```

## Product Style Lock

After approval, extract fixed parameters for every subsequent frame:

```
[PRODUCT STYLE LOCK]
Product: {name}
Shape: {exact shape}
Primary color: {hex}
Secondary color: {hex}
Logo: {text, position, color}
Label: {text, position, color}
Material: {finish type}
Lighting: {key light direction, fill ratio}
Shadow: {contact/drop/none, density %}
Background: {white/gradient/lifestyle}
Camera feel: {35mm/50mm/85mm/100mm}
```

Copy this block into EVERY ad scene prompt unchanged.

## Ad Scene Templates

### Multi-Angle E-Commerce Set
```
Generate {N} product photos, each from a different angle, using product reference as input.

[PRODUCT STYLE LOCK: {paste block}]

Angle 1: Front, straight-on, eye level. Pure white background.
Angle 2: 45-degree from upper-right. Show depth.
Angle 3: Side profile. Highlight details.
Angle 4: Top-down overhead.
Angle 5: Low angle hero shot.

CRITICAL: Product IDENTICAL in every frame. Only angle changes.
```

### Lifestyle Product Ad
```
{product name} in lifestyle setting, commercial photography.

[PRODUCT STYLE LOCK: {paste block}]

[SCENE]: {lifestyle environment}
[COMPOSITION]: Product at {position}, occupying 30-50% of frame.
[LIGHTING]: Natural-looking, key light on product. Colors must match reference EXACTLY.
[PROPS]: {complementary items, none obscuring product}

Product must be pixel-identical to reference sheet. Environment changes. Product does NOT.
```

## Accuracy Check (GLM-4.6V)

```bash
curl -s -X POST 'https://open.bigmodel.cn/api/paas/v4/chat/completions' \
  -H "Authorization: Bearer $ZHIPU_API_KEY" \
  -H 'Content-Type: application/json' \
  -d '{
    "model": "glm-4.6v",
    "messages": [{"role":"user","content":[
      {"type":"image_url","image_url":{"url":"REFERENCE_URL"}},
      {"type":"image_url","image_url":{"url":"GENERATED_URL"}},
      {"type":"text","text":"Compare product accuracy: 1) Shape identical? 2) Logo text/position/color correct? 3) Label accurate? 4) Colors matching? 5) Material finish correct? 6) Proportions correct? Answer ACCURATE or INACCURATE with details."}
    ]}]
  }'
```

**For brand advertising: ZERO tolerance. One wrong letter = reject. One shade off = reject.**
