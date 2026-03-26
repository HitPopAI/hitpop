---
name: hitpop-virtual-idol
description: "AI Virtual Idol pipeline — design character, generate AI cover songs, create lip-sync music videos, and publish to Douyin/TikTok. Full pipeline from character concept to viral content."
version: 0.1.0
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

# Hitpop Virtual Idol — AI Singer/Performer Pipeline

Create AI virtual idols that sing, perform, and post content on Douyin/TikTok. Everything is AI-generated: character design, voice, music video, lip sync.

## Complete Pipeline

```
1. Design Idol  →  2. Setup Voice  →  3. Pick Song  →  4. AI Cover  →  5. Generate MV  →  6. Lip Sync  →  7. Post-Production  →  8. Publish
```

## Step 1: Design the Virtual Idol

Use `hitpop-character-sheet` to create the idol's visual identity.

**Idol Profile** (save as `idol_profiles/{name}.json`):
```json
{
  "name": "星璃",
  "name_en": "Xingli",
  "age": "19",
  "personality": "甜美可爱，有点傲娇，喜欢唱抒情歌",
  "visual_style": "anime",
  "voice_model_url": "https://huggingface.co/.../xingli_rvc_v2.zip",
  "voice_settings": {
    "pitch_change": 0,
    "index_rate": 0.55,
    "reverb_size": 0.15
  },
  "signature_colors": ["#FF69B4", "#FFB6C1", "#FFFFFF"],
  "character_sheet_url": "URL_OF_APPROVED_CHARACTER_SHEET",
  "social_accounts": {
    "douyin": "@xingli_ai",
    "tiktok": "@xingli_ai"
  }
}
```

Generate character sheet with `hitpop-character-sheet` (anime or semi-realistic style). Get user approval before proceeding.

## Step 2: Setup Voice

Two options:

**Option A: Use existing RVC model** from voice-models.com or HuggingFace
- Browse models, find a voice that matches the idol's personality
- Copy the .zip download URL into the idol profile

**Option B: Train custom voice** (better quality, more unique)
- Collect 10-30 minutes of clean vocal audio (from any source)
- Use Replicate's `create-rvc-dataset` + `train-rvc-model` (see `hitpop-ai-cover` skill)
- Save the trained model URL in the idol profile

## Step 3: Pick a Song

Choose a song for the idol to "cover":
- User provides a song file or YouTube link
- Or search for trending songs on Douyin/TikTok
- Instrumentals work best (no need for vocal separation)
- For songs with vocals, the RVC model auto-separates them

## Step 4: Generate AI Cover

Use `hitpop-ai-cover` skill:
```bash
curl -s -X POST "https://api.replicate.com/v1/predictions" \
  -H "Authorization: Bearer $REPLICATE_API_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "version": "zsxkib/realistic-voice-cloning",
    "input": {
      "song_input": "SONG_URL",
      "rvc_model": "CUSTOM",
      "custom_rvc_model_download_url": "IDOL_VOICE_MODEL_URL",
      "pitch_change": 0,
      "index_rate": 0.55,
      "pitch_detection_algo": "rmvpe",
      "output_format": "mp3"
    }
  }'
```
Download the AI cover audio immediately.

## Step 5: Generate Music Video Visuals

Two approaches based on content type:

### MV Type A: Static Image + Lip Sync (simplest, most common on Douyin)
- Use the idol's character sheet or generate a new pose image
- Generate a portrait/upper-body image of the idol in a MV setting:
```
[IDOL CHARACTER BLOCK] in a music studio, wearing headphones, microphone in front, neon lights, [camera: medium close-up, slight low angle], cinematic lighting, 9:16 vertical composition for Douyin/TikTok
```
- Use Seedream 4.5 for the base image
- Then apply lip sync in Step 6

### MV Type B: Animated MV (more effort, higher quality)
- Generate 3-5 scene images of the idol in different poses/settings
- Use img2video (viduq2-img2video) for each scene
- Apply lip sync to key scenes
- Edit together with FFmpeg

### MV Type C: Lyric Video (easiest)
- Generate a background image/video
- Overlay lyrics with timing synced to audio
- Add idol's image as a small inset or watermark

## Step 6: Lip Sync

Use Replicate's SadTalker for image-to-talking-video:

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
      "still": true,
      "preprocess": "crop"
    }
  }'
```

**Parameters:**
| Parameter | Value | Description |
|---|---|---|
| `still` | true | Keeps head still (good for singing videos) |
| `preprocess` | crop | Crops face for best results |
| `enhancer` | gfpgan | Enhances face quality |

**For longer songs (>60s):** Split audio into 30-60s segments, generate lip sync for each, merge with FFmpeg.

**Alternative: OmniHuman API** (if available) — better quality but may require separate API access.

## Step 7: Post-Production

```bash
# Resize to Douyin 9:16 vertical
ffmpeg -i lipsync_output.mp4 -vf "scale=1080:1920:force_original_aspect_ratio=decrease,pad=1080:1920:(ow-iw)/2:(oh-ih)/2" vertical.mp4

# Add song title + idol name overlay
ffmpeg -i vertical.mp4 -vf "drawtext=text='星璃 AI翻唱':fontsize=40:fontcolor=white:x=(w-text_w)/2:y=h-100:fontfile=/path/to/font.ttf" titled.mp4

# Add background effects (optional — subtle particle effects, light leaks)
# Compress for Douyin upload (under 100MB)
ffmpeg -i titled.mp4 -b:v 4M -c:a aac -b:a 192k final.mp4
```

## Step 8: Publish

Use `hitpop-publish` skill to export for Douyin/TikTok:
- Vertical 9:16 (1080x1920)
- Under 100MB
- Add hashtags: #AI翻唱 #虚拟偶像 #AI歌手 #星璃 #hitpop
- Add cover image (use the idol's character image)

## Content Strategy for Viral Growth

### Content Calendar
| Day | Content Type | Description |
|---|---|---|
| Mon | AI Cover | Popular song cover |
| Wed | Behind-the-scenes | Show the AI generation process |
| Fri | AI Cover | Trending song cover |
| Sun | Idol "story" | Short drama or daily life clip using idol character |

### Song Selection Strategy
- Cover trending songs within 24h of them going viral
- Mix Chinese and English songs
- Target songs with strong emotional moments (AI voice shines on ballads)
- Avoid songs with extremely fast rap (RVC quality drops)

### Engagement
- Respond to comments in character (using GLM-5-Turbo)
- Take song requests from fans
- Create "duets" with other AI idols

## Idol Roster (manage multiple idols)

Store all idol profiles in `idol_profiles/` directory:
```
idol_profiles/
├── xingli.json      # Sweet female singer
├── darknight.json   # Cool male rapper
└── mimi.json        # Cute chibi mascot
```

Each idol has their own voice model, visual style, and personality. Use different idols for different song genres.

## Cost Estimate (per song)

| Step | Cost |
|---|---|
| Character image (if new pose needed) | ¥0.25 |
| AI Cover (Replicate RVC) | ~$0.034 (~¥0.25) |
| Lip Sync (Replicate SadTalker) | ~$0.05-0.10 (~¥0.35-0.70) |
| Post-production (FFmpeg) | Free |
| **Total per song** | **~¥0.85-1.20** |

At this cost, you can produce 10+ songs per day for under ¥12.
