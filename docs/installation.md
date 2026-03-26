# Hitpop Agents — Installation Guide

## Prerequisites

1. **OpenClaw CLI** installed and configured
2. **ZHIPU_API_KEY** from https://www.bigmodel.cn/
3. **curl**, **jq**, **ffmpeg** installed

## Step 1: Clone

```bash
git clone https://github.com/HitPopAI/hitpop-agents.git
cd hitpop-agents
```

## Step 2: Run Setup

```bash
chmod +x setup.sh
./setup.sh
```

The script will interactively ask:
- Deployment mode (Channel or Local)
- Channel type (if Channel mode)
- Group ID (if Channel mode)
- LLM model (default: zai/glm-5-turbo)

## Step 3: Set API Key

```bash
export ZHIPU_API_KEY="your-key-here"
```

## Step 4: Start Gateway

```bash
openclaw gateway
```

## Step 5: Talk to Your Fleet

Message the Main agent:
```
Make me a product promo video
```

The fleet takes it from there.

## Troubleshooting

### "Agent not found"
Run `openclaw agents list --bindings` to check if agents were created. Re-run `./setup.sh` if needed.

### "ZHIPU_API_KEY not set"
Make sure you exported the key: `export ZHIPU_API_KEY="your-key"`

### "ffmpeg not found"
Install: `brew install ffmpeg` (macOS) or `apt install ffmpeg` (Linux)

### Agent-to-agent not working
Check that `agentToAgent.enabled` is `true` in `~/.openclaw/openclaw.json`. The setup script should have set this automatically.
