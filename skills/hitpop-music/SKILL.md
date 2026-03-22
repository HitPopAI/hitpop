---
name: hitpop-music
description: "Smart background music selection for videos. Analyzes scene mood/emotion, searches Pixabay Music (free, commercial-use, no attribution required) for matching tracks, downloads and mixes with FFmpeg. Also supports user-provided custom BGM."
version: 0.2.0
metadata:
  openclaw:
    emoji: "🎵"
    requires:
      bins:
        - ffmpeg
        - curl
---

# Hitpop Music — Smart Background Music for Video

Select and mix background music that matches your video's mood, emotion, and pacing. All music from Pixabay is 100% free for commercial use, no attribution required.

## Step 1: Analyze Scene Mood

Before searching for music, analyze the video content and determine the right mood:

| Scene Type | Mood Keywords | Search Terms |
|---|---|---|
| Warm/heartfelt moment | gentle, emotional, touching | `gentle piano emotional` |
| Product showcase (tech) | modern, clean, upbeat | `corporate technology upbeat` |
| Product showcase (luxury) | elegant, sophisticated | `elegant piano luxury` |
| Action/fast-paced | energetic, driving, intense | `energetic electronic fast` |
| Comedy/fun | playful, quirky, lighthearted | `fun playful quirky` |
| Sad/dramatic | melancholy, emotional, slow | `sad piano emotional cinematic` |
| Night city/urban | lo-fi, chill, ambient | `lofi chill night city` |
| Nature/travel | acoustic, peaceful, inspiring | `acoustic guitar nature peaceful` |
| Food/cooking | warm, jazzy, cozy | `jazz cooking warm` |
| Fashion/beauty | trendy, stylish, cool | `fashion stylish modern beat` |
| Kids/family | happy, bright, cheerful | `happy children cheerful` |
| Horror/suspense | dark, tense, eerie | `dark suspense tense` |
| Inspirational | uplifting, motivational | `inspirational uplifting motivational` |
| Advertisement (general) | catchy, positive, professional | `advertising positive corporate` |

## Step 2: Search and Download from Pixabay

Use `web_search` to find the right track, then download it:

```bash
# Step 2a: Search Pixabay Music with mood keywords
# Use web_search tool: "site:pixabay.com/music warm piano emotional short"
# Or browse directly: https://pixabay.com/music/search/gentle piano emotional/

# Step 2b: Once you find a good track, download it
# Pixabay download URLs follow this pattern:
curl -L "https://cdn.pixabay.com/audio/2024/TRACK_PATH.mp3" -o bgm.mp3

# Step 2c: Verify download
ls -la bgm.mp3  # Should be > 0 bytes
ffprobe bgm.mp3  # Check duration and format
```

**Search tips for best results:**
- Add duration: "15 seconds" or "30 seconds" or "short" for short videos
- Add "no vocals" or "instrumental" for background music
- Add "cinematic" for higher production quality tracks
- Try multiple search queries if first results don't match

**Example searches by video type:**

For a convenience store late-night drama:
```
web_search: "pixabay.com music gentle piano night emotional instrumental short"
```

For a tech product ad:
```
web_search: "pixabay.com music modern technology upbeat corporate 15 seconds"
```

For a food product ad:
```
web_search: "pixabay.com music warm jazz cooking cozy instrumental"
```

## Step 3: Mix with Video

```bash
# Add BGM to video (no existing audio)
ffmpeg -i video.mp4 -i bgm.mp3 -c:v copy -c:a aac -map 0:v:0 -map 1:a:0 -shortest output.mp4

# Mix BGM with voiceover (voice at 100%, music at 20%)
ffmpeg -i video.mp4 -i voice.mp3 -i bgm.mp3 \
  -filter_complex "[1:a]volume=1.0[v];[2:a]volume=0.2[m];[v][m]amix=inputs=2:duration=first[aout]" \
  -map 0:v -map "[aout]" -c:v copy -c:a aac output.mp4

# ALWAYS fade in/out for professional feel
ffmpeg -i bgm.mp3 -af "afade=t=in:st=0:d=2,afade=t=out:st=28:d=2" bgm_faded.mp3

# Loop short music to match video length
ffmpeg -stream_loop -1 -i short_bgm.mp3 -i video.mp4 -c:v copy -c:a aac -map 1:v:0 -map 0:a:0 -shortest output.mp4
```

## Option B: User-Provided Custom BGM (Highest Priority)

If the user sends an audio file or says "use this music", ALWAYS use their file instead of searching. This is the highest quality option because the user chose it themselves.

```bash
# User sends bgm.mp3 via Telegram → download it → mix directly
ffmpeg -i video.mp4 -i user_bgm.mp3 \
  -filter_complex "[1:a]volume=0.25,afade=t=in:st=0:d=1,afade=t=out:st=28:d=2[m];[0:a]volume=1.0[v];[v][m]amix=inputs=2:duration=first[aout]" \
  -map 0:v -map "[aout]" -c:v copy -c:a aac output.mp4
```

## Option C: Vidu Q2 Built-in Audio

For quick content where BGM quality is less critical, use Vidu's built-in audio:

```json
{
  "model": "viduq2-text2video",
  "prompt": "...",
  "with_audio": true
}
```

## Music Selection Priority

1. **User-provided BGM** → always use if available
2. **Pixabay search by mood** → analyze scene, search matching track, download
3. **Vidu built-in** → only for quick/draft content

## Rules

1. **ALWAYS analyze scene mood first** — don't pick random music
2. **ALWAYS fade in/out** — 1-2 second fade at start, 2 second fade at end
3. **Keep BGM at 15-25% volume** when mixing with voiceover — music should support, not compete
4. **Match tempo to pacing** — fast cuts = faster music, slow emotional = slower music
5. **Use `-shortest` flag** — auto-trim music to match video length
6. **Verify download before mixing** — check file size > 0, check duration with ffprobe
7. **Never use the same generic track twice** — search for something specific each time
