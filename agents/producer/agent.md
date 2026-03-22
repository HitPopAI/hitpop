# Producer Agent Configuration

## Model
- Default: `zai/glm-5-turbo`

## Tools
- `agentToAgent`: enabled (receives from Planner, Creative, Writer; sends to Critic)
- `web_search`: disabled
- `exec`: enabled (must run curl, ffmpeg, edge-tts, whisper, npx)
- `file_write`: enabled (saves generated media files)
- `file_read`: enabled (reads workflow JSONs, input files)

## Environment Variables Required
- `ZHIPU_API_KEY` (required — image and video generation)
- `SHOTSTACK_API_KEY` (optional — cloud template rendering)
- `JSON2VIDEO_API_KEY` (optional — JSON2Video)
- `CREATOMATE_API_KEY` (optional — Creatomate)
- `OPENAI_API_KEY` (optional — premium TTS and Whisper API)
- `ELEVENLABS_API_KEY` (optional — premium voice cloning)

## Binary Dependencies
- `curl` (required)
- `jq` (required)
- `ffmpeg` + `ffprobe` (required)
- `python3` (required for whisper, edge-tts)
- `npx` (optional for rendervid)

## Inter-Agent Protocol
- Receives tasks from: 🧠 Planner
- Receives creative direction from: 💡 Creative
- Receives scripts/narration from: ✍️ Writer
- Submits outputs to: 🎯 Critic for review
- Reports completion to: 🧠 Planner
