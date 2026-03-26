---
name: hitpop-ai-cover
description: "AI song cover generator — replace vocals in any song with a virtual idol's voice using RVC v2 via Replicate API. Supports custom voice models, pitch adjustment, and automatic vocal/instrumental separation. No GPU needed."
version: 0.1.0
metadata:
  openclaw:
    emoji: "🎤"
    requires:
      env:
        - REPLICATE_API_TOKEN
      bins:
        - curl
        - ffmpeg
---

# Hitpop AI Cover — Virtual Idol Voice Replacement

Replace the vocals in any song with your virtual idol's AI voice. Uses RVC v2 via Replicate cloud API — no local GPU needed.

## How It Works

```
Original Song → Vocal/Instrumental Separation → RVC Voice Conversion → Mix Back → AI Cover
```

The Replicate model handles everything in one call: separation + conversion + mixing.

## Step 1: Get a Voice Model

You need an RVC v2 voice model (.zip containing .pth + .index file). Options:

**Option A: Use pre-made models**
Browse 100,000+ models at:
- https://voice-models.com
- https://huggingface.co/QuickWick/Music-AI-Voices

Copy the download URL of the .zip file.

**Option B: Train a custom voice for your virtual idol**
```bash
# Step 1: Create dataset from any YouTube video of the target voice
curl -s -X POST "https://api.replicate.com/v1/predictions" \
  -H "Authorization: Bearer $REPLICATE_API_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "version": "zsxkib/create-rvc-dataset",
    "input": {
      "youtube_url": "YOUTUBE_URL_WITH_TARGET_VOICE"
    }
  }'

# Step 2: Train model with the dataset
curl -s -X POST "https://api.replicate.com/v1/predictions" \
  -H "Authorization: Bearer $REPLICATE_API_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "version": "replicate/train-rvc-model",
    "input": {
      "dataset_url": "DATASET_ZIP_URL_FROM_STEP_1"
    }
  }'
# Output: a .zip file with your custom voice model
```

## Step 2: Generate AI Cover

```bash
curl -s -X POST "https://api.replicate.com/v1/predictions" \
  -H "Authorization: Bearer $REPLICATE_API_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "version": "zsxkib/realistic-voice-cloning",
    "input": {
      "song_input": "SONG_URL_OR_UPLOADED_FILE",
      "rvc_model": "CUSTOM",
      "custom_rvc_model_download_url": "MODEL_ZIP_URL",
      "pitch_change": 0,
      "index_rate": 0.5,
      "filter_radius": 3,
      "rms_mix_rate": 0.25,
      "pitch_detection_algo": "rmvpe",
      "crepe_hop_length": 128,
      "protect": 0.33,
      "main_vol": 0,
      "backup_vol": 0,
      "inst_vol": 0,
      "pitch_change_all": 0,
      "reverb_size": 0.15,
      "reverb_wetness": 0.2,
      "reverb_dryness": 0.8,
      "reverb_damping": 0.7,
      "output_format": "mp3"
    }
  }'

# Poll for result
curl -s "https://api.replicate.com/v1/predictions/$PREDICTION_ID" \
  -H "Authorization: Bearer $REPLICATE_API_TOKEN"
# Wait until status = "succeeded", then download output URL
```

## Key Parameters

| Parameter | Default | Description |
|---|---|---|
| `pitch_change` | 0 | Semitones. +12 = male→female, -12 = female→male, 0 = same |
| `index_rate` | 0.5 | Voice model influence (0.4-0.7 best range) |
| `pitch_detection_algo` | rmvpe | Best for singing. Use `pm` for speech |
| `main_vol` | 0 | AI vocal volume adjustment (dB) |
| `inst_vol` | 0 | Instrumental volume adjustment (dB) |
| `reverb_size` | 0.15 | Reverb room size (0-1) |
| `output_format` | mp3 | mp3 or wav |

## Cost

~$0.034 per song on Replicate (Nvidia T4 GPU, ~3 minutes processing).

## Virtual Idol Voice Setup

For each virtual idol, maintain a voice profile:

```json
{
  "idol_name": "星璃 (Xingli)",
  "voice_model_url": "https://huggingface.co/.../xingli_rvc_v2.zip",
  "pitch_change": 0,
  "index_rate": 0.55,
  "style_notes": "Sweet female, slightly breathy, good at ballads"
}
```

Store in workspace as `idol_voices/{name}.json`.

## Rules

1. **Always use `rmvpe` for singing** — other algorithms produce worse pitch tracking
2. **Keep `index_rate` between 0.4-0.7** — below sounds too generic, above sounds robotic
3. **Adjust pitch for gender** — +12 for male→female, -12 for female→male
4. **Download output immediately** — Replicate URLs expire
5. **Verify output** — listen to the first 10 seconds before using in video
