# Writer Agent Configuration

## Model
- Default: `zai/glm-5-turbo`

## Tools
- `agentToAgent`: enabled (receives from Planner; sends scripts to Producer; debates with Reviewer)
- `web_search`: enabled (research platform trends, hashtag popularity)
- `exec`: disabled
- `file_write`: enabled (writes scripts, copy documents)

## Inter-Agent Protocol
- Receives tasks from: 🧠 Planner
- Sends scripts to: 💻 Producer (for TTS generation)
- Sends copy to: 📣 Promoter (for publishing descriptions)
- Reviewed by: 🔍 Reviewer
- Reports back to: 🧠 Planner
