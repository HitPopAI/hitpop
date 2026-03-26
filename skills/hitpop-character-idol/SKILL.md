---
name: hitpop-character-idol
description: "Virtual idol identity system — generate photorealistic AI singer base photo, then place the same person into 12+ performance scenes (concert, studio, bedroom guitar, street busking, etc.) using Seedream 4.0 reference image feature. For Douyin/TikTok AI cover accounts."
version: 0.1.0
metadata:
  openclaw:
    emoji: "🌟"
    requires:
      env:
        - ZHIPU_API_KEY
---

# Hitpop Character Idol — Virtual Singer Identity + Scene System

Create a photorealistic AI virtual idol and place them in different performance scenes while keeping the same face. This is a 2-step system: first generate the idol's identity, then generate scene photos.

**Reference accounts**: 抖音 @宋居寒 (1.8万赞), @科莉Kelye (6.4万赞), @苏唯Sue (4.8万赞)

## Pipeline Overview

```
Step 1: Base Identity Photo (白底基准照，一次生成永久复用)
         ↓ (作为 Seedream 4.0 的 images 参考)
Step 2: Scene Photos (同一个人，不同表演场景)
    ├── 🎸 演唱会舞台
    ├── 🎤 Live House 驻唱
    ├── 🎧 录音棚
    ├── 🛏️ 寝室弹吉他
    ├── 🌃 街头驻唱
    ├── 📺 大屏幕演出
    ├── 🌅 日落天台
    ├── 🌧️ 雨中街头
    ├── 🎹 钢琴独奏
    ├── 📼 复古舞台
    ├── ☕ 咖啡厅
    └── 🎬 MV 拍摄现场
         ↓ (场景照 + AI翻唱音频)
Step 3: Lip Sync → 发布抖音 (see hitpop-virtual-idol skill)
```

## Step 1: Base Identity Photo

Generate ONE clean portrait on white background. No scene, no props, no special lighting. Just the person's face and upper body. This is the "face ID" — used as reference for ALL scene photos.

### Prompt Template

```
Photorealistic clean portrait photo of [CHARACTER_DESCRIPTION].

[gender], [age], [ethnicity]. [Face: face shape, skin tone, eye color and shape, eyebrow shape, nose, lip shape, neutral calm expression]. [Hair: exact color name, exact length, exact style, parting, texture]. Wearing [simple solid-color clothing — plain white t-shirt or basic top, nothing distracting from face].

Clean white studio background. Even studio lighting from front, no shadows on face, no color cast. Upper body visible, facing camera directly, eyes looking at camera, shoulders relaxed.

Style: photorealistic clean ID-style portrait, studio lighting, natural skin texture with visible pores, 8K detail, no filters, no heavy post-processing. This photo will be used as a reference to generate this exact person in various scenes — the face and features must be clearly visible and unobstructed.

Aspect ratio: 1:1 square (1024x1024) for maximum face detail.
```

### Example: Male Rock Idol

```
Photorealistic clean portrait photo of a 22-year-old Chinese male singer.

Male, age 22, Chinese. Sharp angular jawline, high cheekbones, fair clean skin with natural texture and visible pores, intense dark brown narrow eyes with slight natural eyeliner effect, strong straight thick eyebrows, straight nose with defined bridge, thin lips in neutral relaxed expression. Platinum blonde long messy hair past shoulders, side-swept bangs partially covering right eye, slightly layered texture.

Wearing plain black crew-neck t-shirt, no logos, no accessories.

Clean white studio background. Even studio lighting from front, no shadows on face, no color cast. Upper body visible, facing camera directly, eyes looking at camera, shoulders relaxed.

Style: photorealistic clean ID-style portrait, studio lighting, natural skin texture with visible pores, 8K detail, no filters, no heavy post-processing. This photo will be used as a reference to generate this exact person in various scenes — the face and features must be clearly visible and unobstructed.

Aspect ratio: 1:1 square (1024x1024).
```

### Example: Female Ballad Idol

```
Photorealistic clean portrait photo of a 20-year-old Chinese female singer.

Female, age 20, Chinese. Round soft face, fair porcelain skin with light natural blush and visible pores, large bright dark brown eyes with double eyelids, soft arched eyebrows, small button nose, full soft pink lips in gentle neutral expression. Dark chestnut brown long straight hair to mid-back, center-parted, silky smooth texture, no accessories.

Wearing plain white crew-neck t-shirt, no logos, no jewelry.

Clean white studio background. Even studio lighting from front, no shadows on face, no color cast. Upper body visible, facing camera directly, eyes looking at camera, shoulders relaxed.

Style: photorealistic clean ID-style portrait, studio lighting, natural skin texture with visible pores, 8K detail, no filters, no heavy post-processing. This photo will be used as a reference to generate this exact person in various scenes — the face and features must be clearly visible and unobstructed.

Aspect ratio: 1:1 square (1024x1024).
```

### Generation API

```bash
curl -s -X POST 'https://open.bigmodel.cn/api/paas/v4/images/generations' \
  -H "Authorization: Bearer $ZHIPU_API_KEY" \
  -H 'Content-Type: application/json' \
  -d '{
    "model": "doubao-seedream-4.5",
    "prompt": "YOUR_BASE_IDENTITY_PROMPT",
    "size": "1024x1024",
    "watermark": false
  }'
```

**CRITICAL: Download and save this image permanently. This is the idol's identity anchor. NEVER delete it. Every scene photo MUST use this as the `images` reference.**

Show to user for approval before proceeding.

## Step 2: Scene Photos

Use **Seedream 4.0** (NOT 4.5) with the base identity photo as the `images` parameter. This ensures the idol's face stays identical across all scenes.

### API Call

```bash
curl -s -X POST 'https://open.bigmodel.cn/api/paas/v4/images/generations' \
  -H "Authorization: Bearer $ZHIPU_API_KEY" \
  -H 'Content-Type: application/json' \
  -d '{
    "model": "doubao-seedream-4.0",
    "prompt": "YOUR_SCENE_PROMPT",
    "images": "BASE_IDENTITY_PHOTO_URL",
    "size": "1080x1920",
    "watermark": false
  }'
```

**MUST use `doubao-seedream-4.0` with `images` parameter. Seedream 4.5 does NOT support reference images. If you use 4.5 or omit `images`, the idol will look like a completely different person.**

### Scene Library — 12 Performance Scenes

Pick the scene based on the song's mood:

#### 1. 演唱会舞台 (Concert Stage)
**Best for**: 摇滚/流行/燃曲
```
Photorealistic photo of [IDOL_CHARACTER_BLOCK] singing passionately on a large concert stage.

Standing at chrome microphone stand, gripping mic with right hand. Wearing [performance outfit]. Concert stage with dramatic purple and blue spotlights from above, fog machine haze across stage floor, Marshall guitar amps and drum kit blurred in background, bokeh crowd phone lights in far background.

Camera: medium close-up from chest up, slight low angle looking up at performer, 9:16 vertical.
Lighting: dramatic purple key light from upper left, blue fill from right, white rim backlight on hair.
Style: photorealistic, Canon EOS R5, 85mm f/1.4, shallow depth of field, natural skin texture, 8K, concert photography.
The person must be the EXACT SAME person as the reference image.
```

#### 2. Live House 驻唱 (Intimate Live House)
**Best for**: 独立/民谣/摇滚小场
```
Photorealistic photo of [IDOL_CHARACTER_BLOCK] performing in an intimate live house venue.

Standing on small wooden stage, holding microphone. Wearing [casual outfit]. Background: exposed brick wall, warm dim Edison bulb string lights, small crowd visible close to stage, bar counter with bottles blurred on one side.

Camera: medium shot waist up, eye level, 9:16 vertical.
Lighting: warm amber Edison bulbs from above, soft orange-yellow tones, intimate cozy atmosphere.
Style: photorealistic, Canon EOS R5, 50mm f/1.8, natural skin texture, 8K, indie concert photography.
The person must be the EXACT SAME person as the reference image.
```

#### 3. 录音棚 (Recording Studio)
**Best for**: 专业感/新歌首发/正式翻唱
```
Photorealistic photo of [IDOL_CHARACTER_BLOCK] recording vocals in a professional studio.

Standing behind large condenser microphone with pop filter, wearing over-ear headphones around neck, one hand touching headphone cup. Wearing [casual but stylish outfit]. Background: soundproof foam panels on walls, mixing console visible through glass window, studio monitor speakers, dim professional lighting.

Camera: medium close-up from chest up, eye level, 9:16 vertical.
Lighting: clean studio ring light from front, subtle blue LED accents on equipment in background.
Style: photorealistic, Canon EOS R5, 85mm f/1.4, shallow depth of field, natural skin texture, 8K.
The person must be the EXACT SAME person as the reference image.
```

#### 4. 寝室弹吉他 (Bedroom Guitar)
**Best for**: 日常/亲切/民谣/翻唱vlog感
```
Photorealistic photo of [IDOL_CHARACTER_BLOCK] singing while playing acoustic guitar in a cozy dormitory room.

Sitting cross-legged on bed, holding acoustic guitar (natural wood color), left hand on fretboard, right hand strumming. Wearing [cozy casual — oversized sweater or t-shirt]. Background: wooden bookshelf with fairy lights (bokeh), messy but cozy bedding, warm desk lamp, some books and plants, typical college dorm.

Camera: medium shot from waist up, eye level, slight head tilt, 9:16 vertical.
Lighting: warm golden desk lamp from right side, soft fairy light bokeh, warm intimate color temperature.
Style: photorealistic, Canon EOS R5, 50mm f/1.8, medium depth of field, natural skin texture, 8K, indie vlog aesthetic.
The person must be the EXACT SAME person as the reference image.
```

#### 5. 街头驻唱 (Street Busking)
**Best for**: 文艺/城市感/自由
```
Photorealistic photo of [IDOL_CHARACTER_BLOCK] busking on a city street at night.

Standing with guitar or at microphone stand, open guitar case on ground. Wearing [street casual — jacket, jeans]. Background: city neon signs and shop lights behind, wet pavement with reflections, blurred pedestrians walking by, urban night atmosphere.

Camera: medium shot, eye level, 9:16 vertical.
Lighting: mixed neon lights (warm yellow shop + cool blue street), wet ground reflections, urban night.
Style: photorealistic, Canon EOS R5, 35mm f/1.4, natural skin texture, 8K, street photography.
The person must be the EXACT SAME person as the reference image.
```

#### 6. 大屏幕演出 (Arena LED Screen)
**Best for**: 万人现场感/爆款歌曲
```
Photorealistic photo of [IDOL_CHARACTER_BLOCK] performing at a large arena with giant LED screens.

Standing center stage, singing into microphone. Wearing [flashy stage outfit]. Background: massive LED screen behind showing colorful visuals, thousands of audience phone lights like stars, huge arena space, professional stage rigging and lights above.

Camera: wide medium shot showing performer and scale of venue, slight low angle, 9:16 vertical.
Lighting: multi-colored stage lights from all directions, strong spotlight on performer, blue and purple arena wash.
Style: photorealistic, Canon EOS R5, 24mm f/1.4, deep depth of field to show venue scale, 8K, arena concert.
The person must be the EXACT SAME person as the reference image.
```

#### 7. 日落天台 (Rooftop Sunset)
**Best for**: 抒情/治愈/情歌
```
Photorealistic photo of [IDOL_CHARACTER_BLOCK] singing on a city rooftop at golden hour sunset.

Standing near rooftop edge, eyes closed, head slightly tilted back, wind blowing hair. Wearing [light flowing outfit]. Background: city skyline silhouette, warm orange-pink sunset sky, scattered clouds with golden edges.

Camera: medium close-up, eye level, 9:16 vertical.
Lighting: warm golden hour sunlight from behind (backlit with rim light on hair), soft orange fill on face.
Style: photorealistic, Canon EOS R5, 85mm f/1.4, golden hour, natural skin texture, 8K, cinematic.
The person must be the EXACT SAME person as the reference image.
```

#### 8. 雨中街头 (Singing in the Rain)
**Best for**: 伤感/情歌/苦情歌
```
Photorealistic photo of [IDOL_CHARACTER_BLOCK] singing emotionally on an empty rainy street.

Standing in light rain, face slightly wet, emotional pained expression, looking slightly upward. Wearing [dark damp clothing]. Background: empty wet street with neon sign reflections on puddles, blurred rain streaks, distant traffic lights, lonely urban night.

Camera: medium close-up, slight low angle, 9:16 vertical.
Lighting: cool blue-green neon reflections, warm distant street lamp, rain droplets catching light.
Style: photorealistic, Canon EOS R5, 85mm f/1.4, rain photography, natural skin texture, 8K, emotional cinematic.
The person must be the EXACT SAME person as the reference image.
```

#### 9. 钢琴独奏 (Piano Solo)
**Best for**: 古典/抒情/优雅
```
Photorealistic photo of [IDOL_CHARACTER_BLOCK] playing grand piano on a dark stage.

Sitting at black grand piano, hands on keys, looking down at hands with focused expression. Wearing [elegant formal outfit — black suit or dress]. Background: completely dark except for single warm spotlight from above, piano surface reflecting light.

Camera: medium shot from slight side angle showing both face and piano, 9:16 vertical.
Lighting: single warm spotlight from above, dramatic contrast, dark moody background.
Style: photorealistic, Canon EOS R5, 50mm f/1.8, dramatic lighting, natural skin texture, 8K, classical concert.
The person must be the EXACT SAME person as the reference image.
```

#### 10. 复古舞台 (Retro Stage)
**Best for**: 80s/90s/怀旧/复古风
```
Photorealistic photo of [IDOL_CHARACTER_BLOCK] performing on a retro-styled stage.

Standing at vintage chrome microphone, one hand on mic stand. Wearing [retro outfit — leather jacket, band t-shirt]. Background: neon signs in pink and blue, vintage stage setup, analog equipment, slight film grain texture, retro color palette with warm amber tones.

Camera: medium close-up, eye level, 9:16 vertical.
Lighting: warm neon pink and blue from sides, amber spotlight from above, vintage film quality.
Style: photorealistic with slight film grain, Canon EOS R5, 85mm f/1.4, retro 90s aesthetic, natural skin texture, 8K, analog warmth.
The person must be the EXACT SAME person as the reference image.
```

#### 11. 咖啡厅 (Cafe Corner)
**Best for**: 轻松/爵士/慢歌/下午茶
```
Photorealistic photo of [IDOL_CHARACTER_BLOCK] singing softly in a cozy cafe corner.

Sitting on wooden stool, holding microphone or acoustic guitar. Wearing [casual comfortable outfit]. Background: warm pendant lights, exposed brick wall, coffee cups on nearby table, small intimate audience of 3-4 people blurred, plants and bookshelves.

Camera: medium shot, eye level, warm tones, 9:16 vertical.
Lighting: warm pendant lights from above, soft golden ambient, cozy cafe atmosphere.
Style: photorealistic, Canon EOS R5, 50mm f/1.8, warm color grading, natural skin texture, 8K, cafe concert.
The person must be the EXACT SAME person as the reference image.
```

#### 12. MV 拍摄现场 (Music Video Set)
**Best for**: 高制作/正式MV/精致内容
```
Photorealistic photo of [IDOL_CHARACTER_BLOCK] being filmed on a professional music video set.

Standing in dramatic pose, singing with emotion. Wearing [styled performance outfit]. Background: professional lighting rigs visible at edges, camera crew silhouettes, director's monitor showing the shot, smoke machine haze, cinematic setup.

Camera: medium close-up, slight low angle, 9:16 vertical.
Lighting: professional three-point film lighting, dramatic but controlled, cinematic quality.
Style: photorealistic, Canon EOS R5, 85mm f/1.4, behind-the-scenes MV feel, natural skin texture, 8K, film production.
The person must be the EXACT SAME person as the reference image.
```

## Consistency Check

After generating each scene photo, run GLM-4.6V to verify it's the same person (see `hitpop-consistency-check` skill):

```bash
curl -s -X POST 'https://open.bigmodel.cn/api/paas/v4/chat/completions' \
  -H "Authorization: Bearer $ZHIPU_API_KEY" \
  -H 'Content-Type: application/json' \
  -d '{
    "model": "glm-4.6v",
    "messages": [{"role":"user","content":[
      {"type":"image_url","image_url":{"url":"BASE_IDENTITY_URL"}},
      {"type":"image_url","image_url":{"url":"SCENE_PHOTO_URL"}},
      {"type":"text","text":"Is the person in image 2 the SAME person as in image 1? Check: same face shape, same eyes, same nose, same hair color and style. Answer SAME_PERSON or DIFFERENT_PERSON with reasons."}
    ]}]
  }'
```

DIFFERENT_PERSON → regenerate. SAME_PERSON → proceed to lip sync.

## Critical Rules

1. **Base identity photo FIRST** — always generate the white-background base photo before any scene photos
2. **Seedream 4.0 for scenes** — MUST use 4.0 with `images` parameter, NOT 4.5
3. **Same base photo for ALL scenes** — never generate a new base photo for different scenes
4. **9:16 vertical** — all scene photos must be 1080x1920 for Douyin/TikTok
5. **Consistency check every scene** — run GLM-4.6V after each scene photo
6. **English prompts** — always write in English for better AI results
7. **User approval on base photo** — show base photo and get approval before generating scenes
8. **3-5 scenes per idol** — generate variety, rotate across songs
9. **Download immediately** — Zhipu URLs expire in 24h
10. **Match scene to song mood** — use the scene library table to pick appropriate setting
