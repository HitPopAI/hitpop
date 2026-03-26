# Planner Agent Configuration

## Model
- Default: `zai/glm-5-turbo`
- Fallback: `zai/glm-4.7`

## Tools
- `agentToAgent`: enabled (can message Creative, Producer, Writer, Scout, Critic)
- `web_search`: disabled (Planner doesn't need to search — Scout does that)
- `exec`: disabled (Planner doesn't execute — Producer does that)
- `file_write`: enabled (writes pipeline plans to workspace)

## Inter-Agent Protocol
- Receives tasks from: 🎬 Main
- Delegates to: 💡 Creative, 💻 Producer, ✍️ Writer, 📰 Scout, 🎯 Critic, 🔍 Reviewer
- Reports back to: 🎬 Main

## Session Key Pattern
```
agent:planner:<channel>:group:<groupId>
```
