---
name: hitpop-scene-guide
description: "Scene image prompt guide — templates for short films, product ads, educational content, and more. Ensures style consistency, correct character/product references, and proper composition for every scene type."
version: 0.1.0
metadata:
  openclaw:
    emoji: "🎬"
---

# Hitpop Scene Guide — Prompt Templates by Content Type

Every scene image prompt MUST follow a consistent structure. Pick the template that matches your content type and fill in the blanks.

## Universal Scene Prompt Structure

```
[STYLE]: {exact same style keyword from character/product sheet}

[CHARACTER]: {verbatim block from character sheet — NO shortening}

[SCENE]: {environment — location, time, weather, ambient lighting}

[ACTION]: {what character is doing — pose, expression, gesture}

[CAMERA]: {shot type, angle, focal length feel}

[LIGHTING]: {direction, color temperature, mood}

[COLOR REFERENCE]: Palette from character sheet: {hex codes}. Environment must COMPLEMENT, not clash.
```

## Short Film / Drama

```
{STYLE from character sheet}, cinematic composition, narrative moment.

[CHARACTER: {verbatim block}]

[SCENE]: {location, time of day, ambient details}

[ACTION]: {character's action, expression, body language}

[CAMERA]: {medium/wide/close-up}, {eye level/low/high}, {depth of field}

[LIGHTING]: {matches time/location — fluorescent for indoors night, golden for sunset, etc.}

[COLOR REFERENCE]: Character palette {hex codes}. Environment complements character colors.
```

## Product Ad — Character + Product

```
{STYLE}, commercial photography style, product hero shot with character.

[CHARACTER: {verbatim block}]

[PRODUCT]: {name, shape, color, label, size, material, logo placement}

[SCENE]: {studio or lifestyle setting}

[ACTION]: Character {interacting with product}. Product clearly visible, ≥30% of frame.

[CAMERA]: {medium close-up, slight low angle for product, or eye-level lifestyle}

[LIGHTING]: Key light on product, fill on character, rim for separation.

[COLOR REFERENCE]: Character {hex}. Product {hex}. Background neutral/complementary.

[COMPOSITION]: Product in foreground or at chest height. Rule of thirds.
```

## Product Ad — Product Only

```
Commercial product photography, {product name}.

[PRODUCT]: {shape, dimensions, color, material, label, logo, texture}

[SCENE]: {studio / marble / gradient / lifestyle flat-lay}

[CAMERA]: {hero shot / 3/4 / flat lay / low angle}

[LIGHTING]: {three-point / window light / dramatic single source}

[PROPS]: {complementary items — never obscure the product}

[COLOR REFERENCE]: Brand colors {hex}. Background within brand family or neutral.
```

## Educational / Explainer

```
{STYLE}, educational video frame, clean and professional.

[CHARACTER: {verbatim block}]

[SCENE]: {clean background — solid color, gradient, minimal studio}

[ACTION]: Facing camera, {presenting gesture}. Friendly, confident.

[CAMERA]: Medium or waist-up, direct eye contact, centered or rule-of-thirds.

[LIGHTING]: Flat, even, professional. No dramatic shadows.

[TEXT SAFE ZONE]: Leave 30% of frame empty on {left/right} for text overlay.
```

## Style Consistency Rules

### Anime/Cartoon
- Same style keywords in EVERY scene prompt
- Background art style must match character style
- Same line weight, shading, color saturation across scenes
- Chibi = all chibi, semi-realistic = all semi-realistic

### Realistic/Live-action
- Same lighting color temperature within same location
- Skin tone hex must match character sheet exactly
- Consistent camera focal length within a sequence
- Clothing wrinkles/fabric texture consistent with material described

### Mixed (cartoon character + real product)
- Product always photorealistic, even with cartoon character
- Use compositing language: "cartoon character with photorealistic product"

## Why Scenes Fail Consistency

| Problem | Cause | Fix |
|---|---|---|
| Character looks different | [CHARACTER] block was shortened | Copy VERBATIM, zero changes |
| Style switched | Style keyword missing | Copy exact style string from sheet |
| Colors shifted | No hex codes in prompt | Always include [COLOR REFERENCE] |
| Clothing changed | Generic "uniform" instead of full detail | Full description every time |
| Character too small | Scene description dominated | Put [CHARACTER] FIRST in prompt |
