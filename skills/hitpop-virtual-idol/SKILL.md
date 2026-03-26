---
name: hitpop-virtual-idol
description: "AI Virtual Idol pipeline — photorealistic AI singer/performer for Douyin/TikTok. Generate realistic human character, AI cover songs (RVC), high-quality lip sync (TopView Avatar 4 / HeyGen), stage scenes, and publish. Full pipeline from character concept to viral content."
version: 0.2.0
metadata:
  openclaw:
    emoji: "🌟"
    requires:
      env:
        - ZHIPU_API_KEY
        - REPLICATE_API_TOKEN
      bins:
        - curl
        - ffmpeg
---

# Hitpop Virtual Idol — Photorealistic AI Singer Pipeline

Create AI virtual idols that look like REAL PEOPLE — singing, performing, and posting on Douyin/TikTok. The audience should NOT be able to tell it's AI at first glance.

**Style: Photorealistic. NOT anime. NOT cartoon. Real human appearance.**

Reference: 抖音上的 @宋居寒, @在野 等写实虚拟偶像账号，1.8万+ 点赞。

## Complete Pipeline

```
1. Design Idol (realistic)  →  2. Generate Face Photo  →  3. Setup Voice (RVC)
       ↓
4. Pick Song  →  5. AI Cover  →  6. Generate Stage Scene
       ↓
7. Lip Sync (TopView/HeyGen)  →  8. Post-Production  →  9. Publish to Douyin
```

## Step 1: Design the Idol

Define the idol's persona (save as `idol_profiles/{name}.json`):

```json
{
  "name": "宋居寒",
  "name_en": "Song Juhan",
  "gender": "male",
  "age": "22",
  "nationality": "Chinese",
  "personality": "冷酷帅气，摇滚气质，舞台霸气但私下温柔",
  "music_style": "摇滚/抒情/古风翻唱",
  "visual_style": "photorealistic",
  "appearance": {
    "face": "sharp jawline, high cheekbones, intense dark eyes",
    "hair": "blonde/silver long hair, styled messy, past shoulders",
    "skin": "fair, clean, Korean idol style",
    "build": "slim, 178cm, model proportions"
  },
  "signature_look": "leather jacket, choker necklace, silver rings, eyeliner",
  "stage_style": "band setup with drums, guitar, moody purple/blue lighting",
  "voice_model_url": "https://huggingface.co/.../songjuhan_rvc_v2.zip",
  "voice_settings": {
    "pitch_change": 0,
    "index_rate": 0.55
  },
  "social_accounts": {
    "douyin": "@songjuhan_ai"
  }
}
```

## Step 2: Generate Base Identity Photo (一次生成，永久复用)

Use Seedream 4.5 to generate ONE clean base portrait. White background, no scene, no props. This is the idol's "face ID" — EVERY scene photo will reference this.

```bash
curl -s -X POST 'https://open.bigmodel.cn/api/paas/v4/images/generations' \
  -H "Authorization: Bearer $ZHIPU_API_KEY" -H 'Content-Type: application/json' \
  -d '{
    "model": "doubao-seedream-4.5",
    "prompt": "Photorealistic clean portrait photo. [IDOL_FACE_DESCRIPTION]. Clean white studio background, even lighting, no shadows, neutral standing pose, facing camera, eyes looking at camera. Natural skin texture with visible pores, 8K detail, no filters.",
    "size": "1024x1024",
    "watermark": false
  }'
```

**CRITICAL: Download and save this image permanently. This is the idol's identity anchor. NEVER delete it. Every scene photo MUST use this as the reference.**

## Step 3: Setup Voice (RVC Model)

**Option A: Download pre-made voice** from HuggingFace
- Browse https://huggingface.co/QuickWick/Music-AI-Voices
- Pick a voice matching the idol's style (male rock singer, female ballad singer, etc.)

**Option B: Train custom voice** on Replicate
- See `hitpop-ai-cover/SKILL.md` for training instructions
- Need 10-30 min of clean vocal audio from any source

Save voice model URL in idol profile JSON.

## Step 4: Pick a Song

Choose songs strategically:
- **Hot on Douyin right now** — ride the trending wave
- **Classic emotional songs** — 古风/情歌 always perform well
- **Songs that suit the idol's voice range** — don't pick soprano for a bass voice
- User can provide a song file, YouTube link, or just a song name

## Step 5: AI Cover

Use `hitpop-ai-cover` skill:
```bash
curl -s -X POST "https://api.replicate.com/v1/predictions" \
  -H "Authorization: Bearer $REPLICATE_API_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "version": "zsxkib/realistic-voice-cloning",
    "input": {
      "song_input": "SONG_URL_OR_FILE",
      "rvc_model": "CUSTOM",
      "custom_rvc_model_download_url": "IDOL_VOICE_MODEL_URL",
      "pitch_change": 0,
      "index_rate": 0.55,
      "pitch_detection_algo": "rmvpe",
      "output_format": "mp3"
    }
  }'
```
Cost: ~$0.034/song. Download output immediately.

## Step 6: Generate Scene Photo (同一个人放进不同场景)

**This is the key step.** Use Seedream 4.0 (NOT 4.5) with the base identity photo from Step 2 as the `images` reference parameter. This keeps the idol's face consistent while placing them in different scenes.

```bash
curl -s -X POST 'https://open.bigmodel.cn/api/paas/v4/images/generations' \
  -H "Authorization: Bearer $ZHIPU_API_KEY" -H 'Content-Type: application/json' \
  -d '{
    "model": "doubao-seedream-4.0",
    "prompt": "SCENE_PROMPT_HERE",
    "images": "BASE_IDENTITY_PHOTO_URL",
    "size": "1080x1920",
    "watermark": false
  }'
```

**Choose the scene based on the song mood:**

| Song Mood | Scene | Prompt Keywords |
|---|---|---|
| 摇滚/燃曲 | 演唱会舞台 | `concert stage, spotlight, fog machine, Marshall amps, crowd silhouettes in background, dramatic purple and blue lighting` |
| 万人现场 | 大屏幕演出 | `giant LED screen showing performer, arena concert, wide angle, thousands of fans with phone lights` |
| 独立/民谣 | Live House | `intimate live house, brick wall background, warm dim Edison bulb lighting, small stage, close audience` |
| 专业/首发 | 录音棚 | `professional recording studio, large condenser microphone with pop filter, headphones around neck, soundproof foam panels` |
| 日常/亲切 | 寝室弹吉他 | `college dormitory room, sitting on bed holding acoustic guitar, warm desk lamp, bookshelf with fairy lights, cozy messy room` |
| 文艺/城市 | 街头驻唱 | `street busking at night, open guitar case, city neon lights behind, wet pavement reflections, pedestrians blurred` |
| 抒情/治愈 | 日落天台 | `rooftop at golden hour, city skyline behind, warm orange sunset light, wind blowing hair, eyes closed singing` |
| 伤感/情歌 | 雨中 | `singing in the rain on empty street, wet reflections, neon signs, emotional pained expression, rain droplets visible` |
| 优雅/古典 | 钢琴独奏 | `sitting at grand piano on stage, single spotlight from above, dark background, elegant formal black outfit` |
| 怀旧/复古 | 复古舞台 | `retro 90s stage setup, neon signs, vintage chrome microphone, leather jacket, film grain texture, warm analog tones` |
| 轻松/爵士 | 咖啡厅 | `cozy cafe corner, small wooden stage, pendant warm lights, exposed brick, holding microphone, intimate setting` |
| 高级/MV | MV现场 | `music video film set, cinematic lighting rigs visible, camera crew silhouettes, professional monitor screens, smoke machine` |

**Scene Prompt Template:**
```
Photorealistic photo of [IDOL_CHARACTER_BLOCK] performing in [SCENE].

[Specific details: location, props, background elements].

[Pose]: [singing into microphone / playing guitar / sitting at piano / standing with eyes closed / looking at camera].

[Camera]: [medium close-up from chest up / upper body / three-quarter body], [eye level / slight low angle], 9:16 vertical for Douyin.

[Lighting]: [scene-appropriate — concert spotlights / warm lamp / studio ring light / golden hour sun / neon reflections].

The person must be the EXACT SAME person as in the reference image — same face, same hair, same features. Only clothing, pose, and scene change.

Style: photorealistic, Canon EOS R5, 85mm f/1.4, shallow depth of field, natural skin texture, 8K, cinematic color grading.
```

**Generate 3-5 different scene photos per idol** — rotate them across different songs so the content doesn't feel repetitive.

## Step 7: Lip Sync (THE MOST CRITICAL STEP)

This is what makes or breaks the virtual idol. Use the BEST available option:

### Option A: TopView Avatar 4 (RECOMMENDED — most realistic)

TopView's Avatar 4 has the best lip sync for realistic virtual humans. It supports:
- Photo to talking video
- Natural head motion + facial expressions
- Emotional mapping
- 30+ languages

```
1. Go to topview.ai/make/video-avatar (or use API)
2. Upload the idol's portrait photo (from Step 2)
3. Upload the AI cover audio (from Step 5)
4. Select Avatar 4 mode
5. Enable "still" mode for singing (minimal head movement)
6. Generate → download
```

**TopView API (if available):**
```bash
curl -X POST "https://api.topview.ai/v1/video/avatar" \
  -H "Authorization: Bearer $TOPVIEW_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "avatar_image": "IDOL_PORTRAIT_URL",
    "audio_url": "AI_COVER_AUDIO_URL",
    "avatar_model": "avatar4",
    "dimension": {"width": 1080, "height": 1920}
  }'
```

Pricing: $18-45/month subscription, or per-credit usage.

### Option B: HeyGen (alternative — also very realistic)

```bash
curl -X POST 'https://api.heygen.com/v2/video/generate' \
  -H "X-Api-Key: $HEYGEN_API_KEY" \
  -H 'Content-Type: application/json' \
  -d '{
    "video_inputs": [{
      "character": {
        "type": "talking_photo",
        "talking_photo_id": "PHOTO_ID"
      },
      "voice": {
        "type": "audio",
        "audio_url": "AI_COVER_AUDIO_URL"
      }
    }],
    "dimension": {"width": 1080, "height": 1920}
  }'
```

Pricing: ~$0.10-0.50/min

### Option C: Replicate SadTalker (cheapest, lower quality)

Only use this as fallback if TopView/HeyGen are unavailable:
```bash
curl -s -X POST "https://api.replicate.com/v1/predictions" \
  -H "Authorization: Bearer $REPLICATE_API_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "version": "cjwbw/sadtalker",
    "input": {
      "source_image": "IDOL_PORTRAIT_URL",
      "driven_audio": "AI_COVER_AUDIO_URL",
      "enhancer": "gfpgan",
      "still": true
    }
  }'
```
Cost: ~$0.05-0.10/min. Quality is lower — more "uncanny valley" risk.

### Lip Sync Quality Priority:
1. **TopView Avatar 4** — best quality, most natural
2. **HeyGen** — very good, established platform
3. **SadTalker** — acceptable for prototyping, not for final publish

## Step 8: Post-Production

```bash
# Combine lip sync video with stage background (picture-in-picture or full screen)
# If lip sync is upper body, composite over stage background:
ffmpeg -i stage_bg.mp4 -i lipsync_video.mp4 \
  -filter_complex "[1:v]scale=1080:1920[fg];[0:v][fg]overlay=0:0" \
  -c:a aac composed.mp4

# Add song lyrics as subtitles
ffmpeg -i composed.mp4 -vf "subtitles=lyrics.srt:force_style='FontSize=28,PrimaryColour=&HFFFFFF&,OutlineColour=&H40000000&,Outline=2,Alignment=2,MarginV=60'" subtitled.mp4

# Add idol name/watermark
ffmpeg -i subtitled.mp4 -vf "drawtext=text='@宋居寒 AI翻唱':fontsize=24:fontcolor=white@0.7:x=20:y=h-60" final.mp4

# Compress for Douyin (under 100MB)
ffmpeg -i final.mp4 -b:v 4M -c:a aac -b:a 192k -movflags +faststart upload_ready.mp4
```

## Step 9: Publish to Douyin

Export specs:
- **Format**: MP4, H.264
- **Resolution**: 1080x1920 (9:16 vertical)
- **Size**: Under 100MB
- **Duration**: 15s-3min (sweet spot: 30-60s for covers)

Douyin posting checklist:
- ✅ Add "作者声明：内容由 AI 生成" (required by platform rules)
- ✅ Hashtags: #AI翻唱 #虚拟偶像 #AI歌手 #{idol_name} #{song_name}
- ✅ Song tag: link the original song via Douyin's music tag
- ✅ Cover image: use the idol's portrait photo

## Content Strategy

### Song Selection for Maximum Virality
| Song Type | Why It Works | Example |
|---|---|---|
| 古风热歌 | Huge audience on Douyin | 笑纳, 赤伶, 探窗 |
| 经典情歌 | Emotional resonance | 光辉岁月, 晴天, 告白气球 |
| 当前热门 | Algorithm boost from trending | Whatever's #1 this week |
| 英文热歌翻唱 | Cross-cultural novelty | Shape of You, Love Story |

### Posting Schedule
- **3-5 covers per week** — consistency is key for algorithm
- **Best times**: 12:00-13:00, 18:00-20:00, 21:00-23:00
- **Alternate styles**: ballad → rock → 古风 → pop (show range)

### Engagement
- Respond to comments in character (use GLM-5-Turbo with idol's personality prompt)
- Take song requests from fans
- Occasionally show "behind the scenes" AI generation process

## Cost Per Song

| Step | Tool | Cost |
|---|---|---|
| Idol portrait (reuse) | Seedream 4.5 | ¥0.25 (one-time) |
| AI Cover | Replicate RVC | ~¥0.25 ($0.034) |
| Lip Sync | TopView Avatar 4 | ~¥2-5 (per credit) |
| Stage scene (reuse) | Seedream 4.5 | ¥0.25 (one-time) |
| Post-production | FFmpeg | Free |
| **Total per new song** | | **~¥2.50-5.50** |

## Idol Roster

Manage multiple idols for different audiences:

```
idol_profiles/
├── songjuhan.json    # 冷酷摇滚男 — 古风/摇滚翻唱
├── linxi.json        # 甜美女生 — 情歌/流行翻唱
├── darkprince.json   # 暗黑王子 — 说唱/电子翻唱
└── xiaomeng.json     # 清纯邻家 — 民谣/轻音乐
```

Each idol has unique: appearance, voice model, personality, target audience, song style.
