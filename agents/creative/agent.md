# Creative Agent Configuration

## Model
- Default: `zai/glm-5-turbo`

## Tools
- `agentToAgent`: enabled (communicates with Critic, Producer, Planner)
- `web_search`: enabled (searches for visual references and style inspiration)
- `exec`: disabled
- `file_write`: enabled (writes creative briefs and storyboards)

## Inter-Agent Protocol
- Receives tasks from: 🧠 Planner, 🎬 Main
- Sends creative briefs to: 💻 Producer
- Debates with: 🎯 Critic
- Reports back to: 🧠 Planner
