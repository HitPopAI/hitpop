---
name: hitpop-voiceover
description: "AI voiceover and text-to-speech for video narration. Primary: GLM-TTS via Zhipu API (emotional, stable, same API key). Fallback: Edge TTS (free). Also supports OpenAI TTS and ElevenLabs."
version: 0.1.0
metadata:
  openclaw:
    emoji: "🎙️"
    requires:
      bins:
        - curl
        - ffmpeg
---

# Hitpop Voiceover — AI Text-to-Speech for Video

Generate voiceovers for your videos using multiple TTS providers.

## Option 1: GLM-TTS via Zhipu API (Recommended — Same API Key)

GLM-TTS — emotional, natural, stable. Uses the same `ZHIPU_API_KEY` as video/image generation. Supports 7 voice characters with emotional expression.

```bash
# Generate voiceover (outputs wav)
curl -X POST "https://open.bigmodel.cn/api/paas/v4/audio/speech" \
  -H "Authorization: Bearer $ZHIPU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "glm-tts",
    "input": "Your narration text here",
    "voice": "female",
    "speed": 1.0,
    "volume": 1.0,
    "response_format": "wav"
  }' --output voiceover.wav

# Convert to mp3 for smaller file
ffmpeg -i voiceover.wav -codec:a libmp3lame -b:a 192k voiceover.mp3
```

**Voices:**
| Voice ID | Character | Best for |
|---|---|---|
| `female` | Tongtong (default) | Narration, warm female |
| `xiaochen` | Xiao Chen | Young professional female |
| `chuichui` | Chuichui | Energetic, youthful |
| `jam` | Jam | Male, casual |
| `kazi` | Kazi | Male, mature |
| `douji` | Douji | Male, friendly |
| `luodo` | Luodo | Male, deep |

**Parameters:** `speed` (0.5-2.0), `volume` (0.5-2.0), `response_format` (wav/mp3/pcm)

**Multi-character dialogue:** Use different voice IDs per character, generate each line separately, merge with FFmpeg.

## Option 2: Edge TTS (Free Fallback, No API Key)

Microsoft Edge TTS — free, 300+ voices, 75+ languages.

```bash
pip install edge-tts

# List available voices
edge-tts --list-voices | grep en-US

# Generate voiceover
edge-tts --voice "en-US-AriaNeural" --text "Welcome to our product showcase" --write-media voiceover.mp3

# Chinese voice
edge-tts --voice "zh-CN-XiaoxiaoNeural" --text "Welcome to our product showcase" --write-media voiceover_cn.mp3
```

## Option 3: OpenAI TTS (Best Quality)

Requires `OPENAI_API_KEY`.

```bash
curl -s https://api.openai.com/v1/audio/speech \
  -H "Authorization: Bearer $OPENAI_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "tts-1-hd",
    "input": "Welcome to our product showcase. Today we are introducing something incredible.",
    "voice": "nova"
  }' --output voiceover.mp3
```

Voices: `alloy`, `echo`, `fable`, `onyx`, `nova`, `shimmer`

## Option 4: ElevenLabs (Most Natural)

Requires `ELEVENLABS_API_KEY`.

```bash
curl -s -X POST "https://api.elevenlabs.io/v1/text-to-speech/21m00Tcm4TlvDq8ikWAM" \
  -H "xi-api-key: $ELEVENLABS_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "text": "Welcome to our product showcase.",
    "model_id": "eleven_multilingual_v2"
  }' --output voiceover.mp3
```

## Merge Voiceover with Video

```bash
# Replace audio
ffmpeg -i video.mp4 -i voiceover.mp3 -c:v copy -c:a aac -map 0:v:0 -map 1:a:0 -shortest output.mp4

# Mix with existing audio (voice at full volume, original at 20%)
ffmpeg -i video.mp4 -i voiceover.mp3 \
  -filter_complex "[0:a]volume=0.2[orig];[1:a]volume=1.0[voice];[orig][voice]amix=inputs=2:duration=first[aout]" \
  -map 0:v -map "[aout]" -c:v copy -c:a aac output.mp4
```

## Tips
- Use GLM-TTS as primary — same API key as video generation, best Chinese quality, emotional expression
- Fall back to Edge TTS if GLM-TTS is down or for quick prototyping
- Use OpenAI/ElevenLabs for premium English voiceovers
- Generate voiceover first, then use its duration to set video length
- For long scripts, split into segments (≤300 chars), generate separately, then concat with FFmpeg
- For multi-character scenes, use different GLM-TTS voice IDs per character
