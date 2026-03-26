# Reviewer Agent Configuration

## Model
- Default: `zai/glm-5-turbo`

## Tools
- `agentToAgent`: enabled (receives from Planner; sends revision requests to Producer, Writer)
- `web_search`: disabled
- `exec`: enabled (needs ffprobe to check video specs)
- `file_read`: enabled (reads output files for review)

## Inter-Agent Protocol
- Receives review requests from: 🧠 Planner, 🎬 Main
- Can send REVISION requests to: 💻 Producer, ✍️ Writer
- Reports final verdict to: 🎬 Main (for user delivery)
