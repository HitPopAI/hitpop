---
name: hitpop-lipsync
description: "AI Lip Sync — make characters speak with perfectly synchronized mouth movements. Supports audio-driven lip sync on existing video (Wav2Lip), single-image talking head generation (SadTalker, LivePortrait), and commercial avatar APIs (HeyGen, Kling Avatar). Essential for AI short films, product spokespersons, and multilingual dubbing."
version: 0.1.0
metadata:
  openclaw:
    emoji: "👄"
    requires:
      bins:
        - python3
        - ffmpeg
---

# Hitpop Lip Sync — Audio-Driven Talking Video

You are executing lip sync tasks. Your job is to make a character's mouth move naturally in sync with speech audio. This is the missing piece between AI-generated video and believable dialogue.

## When to Use This Skill

- User has a video clip and wants a character to "speak" specific dialogue
- User has a single portrait image and wants to create a talking head video
- User needs multilingual dubbing (change the audio, re-sync the lips)
- User is making an AI short film/drama with dialogue
- User wants a digital spokesperson for product demos

## Method Selection

```
What input do you have?
├── Video + new audio → RE-SYNC (Wav2Lip or Sync Lipsync)
│   Best for: dubbing, dialogue replacement, translation
│
├── Single image + audio → TALKING HEAD (SadTalker or LivePortrait)
│   Best for: spokesperson videos, quick content from a photo
│
├── Need full avatar with gestures → AVATAR API (HeyGen or Kling Avatar)
│   Best for: professional presenter videos, training content
│
└── Local + free → OPEN SOURCE (Wav2Lip + SadTalker via ComfyUI or CLI)
    Best for: developers with GPU, batch processing
```

## Method 1: Wav2Lip (Open Source — Best for Re-syncing Existing Video)

The industry standard for applying new lip movements to existing footage. Works on any face in any video.

### Install

```bash
# Clone Wav2Lip
git clone https://github.com/Rudrabha/Wav2Lip.git
cd Wav2Lip

# Install dependencies
pip install -r requirements.txt

# Download pretrained model (place in checkpoints/)
# wav2lip_gan.pth — best quality
# wav2lip.pth — faster, slightly lower quality
mkdir -p checkpoints
# Download from: https://github.com/Rudrabha/Wav2Lip#getting-the-weights
```

### Usage

```bash
# Basic lip sync: video + audio → synced video
python inference.py \
  --checkpoint_path checkpoints/wav2lip_gan.pth \
  --face input_video.mp4 \
  --audio voice.mp3 \
  --outfile output_synced.mp4

# With quality options
python inference.py \
  --checkpoint_path checkpoints/wav2lip_gan.pth \
  --face input_video.mp4 \
  --audio voice.mp3 \
  --outfile output_synced.mp4 \
  --resize_factor 1 \
  --nosmooth
```

### Post-processing (sharpen face region after Wav2Lip)

```bash
# Wav2Lip output can be slightly blurry around the mouth
# Use Real-ESRGAN or CodeFormer to enhance face quality
pip install realesrgan

# Or use FFmpeg unsharp mask as a quick fix
ffmpeg -i output_synced.mp4 -vf "unsharp=5:5:1.0:5:5:0.0" output_enhanced.mp4
```

### Strengths and Limits
- Works on ANY face in ANY video (real, AI-generated, animated)
- Excellent audio-lip alignment accuracy
- Does NOT generate head movement or expressions — only mouth region
- Output may need face enhancement (CodeFormer / GFPGAN)

---

## Method 2: SadTalker (Open Source — Image to Talking Head)

Generate a full talking head video from a single portrait image + audio. Adds natural head movement, eye blinks, and expressions.

### Install

```bash
git clone https://github.com/OpenTalker/SadTalker.git
cd SadTalker
pip install -r requirements.txt

# Download pretrained models
bash scripts/download_models.sh
```

### Usage

```bash
# Single image + audio → talking video
python inference.py \
  --driven_audio voice.mp3 \
  --source_image portrait.png \
  --result_dir ./results \
  --enhancer gfpgan \
  --still  # minimal head motion (good for formal content)

# With more expression
python inference.py \
  --driven_audio voice.mp3 \
  --source_image portrait.png \
  --result_dir ./results \
  --enhancer gfpgan \
  --expression_scale 1.2 \
  --pose_style 3
```

### Strengths and Limits
- Creates full talking head from ONE image
- Adds natural head pose, eye blinks, expressions
- Best with front-facing portraits, good lighting
- May drift on very long audio (>60s) — split into segments
- Expression can feel exaggerated — tune with `--expression_scale`

---

## Method 3: LivePortrait (Open Source — High Fidelity)

The newest open-source option. Higher fidelity than SadTalker with better emotion-aware animation and identity preservation.

### Install

```bash
git clone https://github.com/KwaiVGI/LivePortrait.git
cd LivePortrait
pip install -r requirements.txt

# Download models
python scripts/download_models.py
```

### Usage

```bash
# Image + audio → talking video
python inference.py \
  --source_image portrait.png \
  --driving_audio voice.mp3 \
  --output_path result.mp4
```

### Strengths and Limits
- Best open-source quality as of 2026
- Strong identity preservation
- Emotion-aware (matches vocal tone to facial expression)
- Requires decent GPU (8GB+ VRAM)
- Newer project, community smaller than Wav2Lip/SadTalker

---

## Method 4: Commercial APIs (No GPU Required)

### HeyGen API

```bash
# Create talking avatar video
curl -X POST 'https://api.heygen.com/v2/video/generate' \
  -H 'Content-Type: application/json' \
  -H "X-Api-Key: $HEYGEN_API_KEY" \
  -d '{
    "video_inputs": [{
      "character": {
        "type": "talking_photo",
        "talking_photo_id": "PHOTO_ID"
      },
      "voice": {
        "type": "audio",
        "audio_url": "AUDIO_URL"
      }
    }],
    "dimension": {"width": 1080, "height": 1920}
  }'

# Poll for result
curl 'https://api.heygen.com/v1/video_status.get?video_id=VIDEO_ID' \
  -H "X-Api-Key: $HEYGEN_API_KEY"
```

**Pricing**: ~$0.10-0.50 per minute of video
**Best for**: Professional spokesperson videos, marketing content

### Kling Avatar Pro (via Kuaishou)

Audio-driven avatar with natural head motion and lip sync. Integrated into Kling's video generation pipeline.

**Best for**: Chinese market content, integration with Kling video generation

### Sync Lipsync 2.0 (via fal.ai)

```bash
# Video-to-video lip sync via fal.ai
curl -X POST 'https://queue.fal.run/fal-ai/sync-lipsync' \
  -H 'Content-Type: application/json' \
  -H "Authorization: Key $FAL_API_KEY" \
  -d '{
    "video_url": "VIDEO_URL",
    "audio_url": "AUDIO_URL"
  }'
```

**Best for**: Quick cloud-based re-sync without local GPU

---

## Integration with Hitpop Pipeline

### Typical AI Short Film Pipeline with Lip Sync

```json
{
  "name": "AI Short Film with Dialogue",
  "steps": [
    {"id": "images", "skill": "hitpop-gen-image", "description": "Generate character portraits for each role"},
    {"id": "scenes", "skill": "hitpop-gen-video", "description": "Generate scene clips with character consistency (viduq2-img2video)"},
    {"id": "voices", "skill": "hitpop-voiceover", "description": "Generate dialogue audio for each character"},
    {"id": "lipsync", "skill": "hitpop-lipsync", "description": "Apply lip sync to match dialogue with character faces"},
    {"id": "subs", "skill": "hitpop-subtitle", "description": "Auto-generate subtitles from dialogue"},
    {"id": "merge", "skill": "hitpop-edit", "description": "Merge all scenes + dialogue + subtitles + BGM"},
    {"id": "export", "skill": "hitpop-publish", "description": "Export for target platform"}
  ]
}
```

### Talking Spokesperson Pipeline

```json
{
  "name": "Product Spokesperson",
  "steps": [
    {"id": "portrait", "skill": "hitpop-gen-image", "description": "Generate spokesperson portrait"},
    {"id": "script", "skill": "hitpop-voiceover", "description": "Generate narration audio"},
    {"id": "talking", "skill": "hitpop-lipsync", "description": "Create talking head video from portrait + audio"},
    {"id": "export", "skill": "hitpop-publish", "description": "Export for platform"}
  ]
}
```

## Decision Guide

| Scenario | Method | Cost | GPU Required |
|---|---|---|---|
| Re-dub existing AI video | Wav2Lip | Free | Yes (or Colab) |
| Talking head from photo | SadTalker / LivePortrait | Free | Yes |
| Professional avatar | HeyGen API | ~$0.10-0.50/min | No |
| Chinese market avatar | Kling Avatar Pro | Pay per use | No |
| Cloud re-sync, no GPU | Sync Lipsync 2.0 (fal.ai) | Pay per use | No |
| Batch processing | Wav2Lip + FFmpeg loop | Free | Yes |

## Important Notes

- **Face quality matters**: Lip sync works best on clear, well-lit faces. AI-generated faces from Seedream work great.
- **Audio quality matters**: Clean speech audio gives best results. Remove background noise first with FFmpeg: `ffmpeg -i noisy.mp3 -af "highpass=f=200,lowpass=f=3000,afftdn" clean.mp3`
- **Segment long dialogue**: For videos >30s, split into segments, lip-sync each, then merge. This prevents drift.
- **Face enhancement after Wav2Lip**: Always run GFPGAN or CodeFormer on the output to sharpen the mouth region.
- **Combine with hitpop-gen-video**: Generate the base video with Vidu Q2, then apply lip sync as a post-processing step.
