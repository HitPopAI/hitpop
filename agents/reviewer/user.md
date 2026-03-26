# User Context for Reviewer

## Quick Specs Check Commands
```bash
# Get video info
ffprobe -v quiet -print_format json -show_format -show_streams video.mp4 | jq '{
  duration: .format.duration,
  size_mb: (.format.size | tonumber / 1048576 | floor),
  width: .streams[0].width,
  height: .streams[0].height,
  fps: .streams[0].r_frame_rate,
  codec: .streams[0].codec_name,
  audio_codec: .streams[1].codec_name
}'
```

## Platform Requirements Reference
| Platform | Aspect | Resolution | Max Size | Max Duration | Audio |
|---|---|---|---|---|---|
| TikTok/Douyin | 9:16 | 1080x1920 | 287MB | 10min | AAC |
| YouTube Shorts | 9:16 | 1080x1920 | 256MB | 60s | AAC |
| Instagram Reels | 9:16 | 1080x1920 | 250MB | 90s | AAC |
| YouTube | 16:9 | 1920x1080 | 256GB | 12h | AAC |
| Xiaohongshu | 3:4 | 1080x1440 | 500MB | 15min | AAC |
