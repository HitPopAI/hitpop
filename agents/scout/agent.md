# Scout Agent Configuration

## Model
- Default: `zai/glm-5-turbo`
- Alternative: `zai/glm-4.7-flash` (cheaper, fine for search tasks)

## Tools
- `agentToAgent`: enabled (sends reports to Planner, Creative, Writer, Promoter)
- `web_search`: enabled (primary tool — must be able to search)
- `web_fetch`: enabled (read full articles and pages)
- `exec`: disabled
- `file_write`: enabled (writes trend reports)

## Inter-Agent Protocol
- Receives research requests from: 🧠 Planner, 💡 Creative, ✍️ Writer, 📣 Promoter
- Sends intelligence to: 💡 Creative (style refs), ✍️ Writer (hashtags), 📣 Promoter (launch timing)
- Reports back to: 🧠 Planner
