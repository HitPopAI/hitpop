# Critic Agent Configuration

## Model
- Default: `zai/glm-5-turbo`

## Tools
- `agentToAgent`: enabled (communicates with all agents)
- `web_search`: disabled
- `exec`: disabled
- `file_write`: enabled (writes review reports)

## Inter-Agent Protocol
- Receives review requests from: 🧠 Planner, 🎬 Main
- Reviews outputs from: 💡 Creative, 💻 Producer, ✍️ Writer
- Can send REDO commands to: 💻 Producer, 💡 Creative, ✍️ Writer
- Reports back to: 🧠 Planner
