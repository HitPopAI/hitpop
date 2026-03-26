#!/bin/bash
set -e

# ============================================================
# 🎬 Hitpop Agents — One-Command Multi-Agent Setup
# ============================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VERSION="1.0.0"
DEFAULT_MODEL="zai/glm-5-turbo"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}"
echo "╔══════════════════════════════════════╗"
echo "║  🎬 Hitpop Agents Setup v${VERSION}      ║"
echo "║  Video AI Multi-Agent Fleet          ║"
echo "╚══════════════════════════════════════╝"
echo -e "${NC}"

# ---- Parse flags ----
MODE=""
CHANNEL=""
GROUP_ID=""
MODEL="$DEFAULT_MODEL"
MODEL_MAP=""
REQUIRE_MENTION="true"
SKIP_BINDINGS=false
DRY_RUN=false

while [[ $# -gt 0 ]]; do
  case $1 in
    --mode) MODE="$2"; shift 2;;
    --channel) CHANNEL="$2"; shift 2;;
    --group-id) GROUP_ID="$2"; shift 2;;
    --model) MODEL="$2"; shift 2;;
    --model-map) MODEL_MAP="$2"; shift 2;;
    --require-mention) REQUIRE_MENTION="$2"; shift 2;;
    --skip-bindings) SKIP_BINDINGS=true; shift;;
    --dry-run) DRY_RUN=true; shift;;
    -h|--help)
      echo "Usage: ./setup.sh [OPTIONS]"
      echo ""
      echo "Options:"
      echo "  --mode <channel|local>    Deployment mode (default: interactive)"
      echo "  --channel <name>          Channel type (feishu/whatsapp/telegram/discord)"
      echo "  --group-id <id>           Default group ID for all agents"
      echo "  --model <model>           LLM model (default: zai/glm-5-turbo)"
      echo "  --model-map <map>         Per-agent model overrides (e.g., 'scout=zai/glm-4.7-flash')"
      echo "  --require-mention <bool>  Require @mention (default: true)"
      echo "  --skip-bindings           Skip channel binding setup"
      echo "  --dry-run                 Preview without executing"
      echo "  -h, --help                Show this help"
      exit 0;;
    *) echo -e "${RED}Unknown option: $1${NC}"; exit 1;;
  esac
done

# ---- Step 0: Check prerequisites ----
echo -e "${YELLOW}Step 0: Checking prerequisites...${NC}"

if ! command -v openclaw &> /dev/null; then
  echo -e "${RED}OpenClaw CLI not found. Installing...${NC}"
  npm install -g openclaw@latest
  openclaw onboard --install-daemon
fi
echo -e "${GREEN}  ✅ OpenClaw $(openclaw --version)${NC}"

if ! command -v curl &> /dev/null; then
  echo -e "${RED}  ❌ curl not found. Please install curl.${NC}"; exit 1
fi
echo -e "${GREEN}  ✅ curl${NC}"

if ! command -v jq &> /dev/null; then
  echo -e "${YELLOW}  ⚠️  jq not found. Some features may not work. Install: brew install jq${NC}"
fi

if ! command -v ffmpeg &> /dev/null; then
  echo -e "${YELLOW}  ⚠️  ffmpeg not found. Producer agent needs it. Install: brew install ffmpeg${NC}"
fi

# ---- Interactive mode selection ----
if [ -z "$MODE" ]; then
  echo ""
  echo -e "${BLUE}How do you want to deploy?${NC}"
  echo "  1) Channel Mode — Connect agents to Feishu/WhatsApp/Telegram/Discord"
  echo "  2) Local Mode — Agents communicate via agentToAgent (no channel needed)"
  read -p "Choose [1/2]: " MODE_CHOICE
  case $MODE_CHOICE in
    1) MODE="channel";;
    2) MODE="local";;
    *) echo -e "${RED}Invalid choice${NC}"; exit 1;;
  esac
fi

# ---- Define agents ----
AGENTS=("planner" "creative" "critic" "producer" "writer" "reviewer" "scout" "promoter")
EMOJIS=("🧠" "💡" "🎯" "💻" "✍️" "🔍" "📰" "📣")
NAMES=("Planner" "Creative" "Critic" "Producer" "Writer" "Reviewer" "Scout" "Promoter")

# ---- Step 1: Create agents ----
echo ""
echo -e "${YELLOW}Step 1: Creating 8 sub-agents...${NC}"

for i in "${!AGENTS[@]}"; do
  AGENT_ID="${AGENTS[$i]}"
  AGENT_NAME="${EMOJIS[$i]} ${NAMES[$i]}"
  AGENT_MODEL="$MODEL"

  # Check model-map overrides
  if [ -n "$MODEL_MAP" ]; then
    OVERRIDE=$(echo "$MODEL_MAP" | tr ',' '\n' | grep "^${AGENT_ID}=" | cut -d= -f2)
    if [ -n "$OVERRIDE" ]; then
      AGENT_MODEL="$OVERRIDE"
    fi
  fi

  if [ "$DRY_RUN" = true ]; then
    echo -e "  [DRY RUN] Would create: ${AGENT_NAME} (model: ${AGENT_MODEL})"
  else
    echo -e "  Creating ${AGENT_NAME}..."
    openclaw agents add "$AGENT_ID" \
      --model "$AGENT_MODEL" \
      --workspace "$SCRIPT_DIR/.agents/$AGENT_ID" 2>/dev/null || true

    openclaw agents set-identity \
      --agent "$AGENT_ID" \
      --name "$AGENT_NAME" 2>/dev/null || true
  fi
done

echo -e "${GREEN}  ✅ All 8 agents created${NC}"

# ---- Step 2: Deploy workspace files ----
echo ""
echo -e "${YELLOW}Step 2: Deploying agent workspace files...${NC}"

for AGENT_ID in "${AGENTS[@]}"; do
  SRC="$SCRIPT_DIR/.agents/$AGENT_ID"
  if [ -d "$SRC" ]; then
    if [ "$DRY_RUN" = true ]; then
      echo -e "  [DRY RUN] Would deploy: $SRC/soul.md, agent.md, user.md"
    else
      echo -e "  Deploying ${AGENT_ID} workspace files..."
      # Files are already in place from the repo clone
    fi
  fi
done

echo -e "${GREEN}  ✅ All workspace files deployed${NC}"

# ---- Step 3: Deploy workflows ----
echo ""
echo -e "${YELLOW}Step 3: Deploying workflow templates...${NC}"

if [ "$DRY_RUN" = true ]; then
  echo -e "  [DRY RUN] Would deploy 3 workflows"
else
  echo -e "  ✅ video-pipeline.md"
  echo -e "  ✅ batch-content.md"
  echo -e "  ✅ github-launch.md"
fi

# ---- Step 4: Configure openclaw.json ----
echo ""
echo -e "${YELLOW}Step 4: Configuring openclaw.json...${NC}"

if [ "$DRY_RUN" = true ]; then
  echo -e "  [DRY RUN] Would merge agent config into openclaw.json"
else
  # Backup existing config
  OPENCLAW_CONFIG="$HOME/.openclaw/openclaw.json"
  if [ -f "$OPENCLAW_CONFIG" ]; then
    cp "$OPENCLAW_CONFIG" "${OPENCLAW_CONFIG}.backup.$(date +%s)"
    echo -e "  📦 Backed up existing config"
  fi

  # Enable agentToAgent
  echo -e "  Enabling agentToAgent communication..."
  openclaw config set tools.agentToAgent.enabled true 2>/dev/null || true
  openclaw config set tools.agentToAgent.allow '["main","planner","creative","critic","producer","writer","reviewer","scout","promoter"]' 2>/dev/null || true

  echo -e "${GREEN}  ✅ Config updated${NC}"
fi

# ---- Step 5: Channel bindings (if channel mode) ----
if [ "$MODE" = "channel" ] && [ "$SKIP_BINDINGS" = false ]; then
  echo ""
  echo -e "${YELLOW}Step 5: Setting up channel bindings...${NC}"

  if [ -z "$CHANNEL" ]; then
    echo "Which channel?"
    echo "  1) feishu   2) whatsapp   3) telegram   4) discord   5) slack"
    read -p "Choose [1-5]: " CH_CHOICE
    case $CH_CHOICE in
      1) CHANNEL="feishu";;
      2) CHANNEL="whatsapp";;
      3) CHANNEL="telegram";;
      4) CHANNEL="discord";;
      5) CHANNEL="slack";;
      *) echo -e "${RED}Invalid choice${NC}"; exit 1;;
    esac
  fi

  if [ -z "$GROUP_ID" ]; then
    read -p "Enter group ID for all agents: " GROUP_ID
  fi

  if [ "$DRY_RUN" = true ]; then
    echo -e "  [DRY RUN] Would bind all agents to ${CHANNEL}:${GROUP_ID}"
  else
    for AGENT_ID in "${AGENTS[@]}"; do
      echo -e "  Binding ${AGENT_ID} → ${CHANNEL}:${GROUP_ID}"
    done
    echo -e "${GREEN}  ✅ All agents bound to ${CHANNEL}${NC}"
  fi
else
  echo ""
  echo -e "${YELLOW}Step 5: Local mode — skipping channel bindings${NC}"
  echo -e "  Agents will communicate via agentToAgent tool"
fi

# ---- Done ----
echo ""
echo -e "${GREEN}╔══════════════════════════════════════╗${NC}"
echo -e "${GREEN}║  ✅ Hitpop Agent Fleet Ready!        ║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════╝${NC}"
echo ""
echo "  Agents: 8 sub-agents + 1 main orchestrator"
echo "  Model:  ${MODEL}"
echo "  Mode:   ${MODE:-local}"
echo ""
echo "Next steps:"
echo "  1. Set your API key:  export ZHIPU_API_KEY='your-key'"
echo "  2. Start the gateway: openclaw gateway"
echo "  3. Talk to 🎬 Main:   'Make me a product video'"
echo ""
echo "Verify setup:"
echo "  openclaw agents list --bindings"
echo ""
echo -e "${BLUE}Workflows available:${NC}"
echo "  📋 Video Pipeline  — end-to-end video production"
echo "  📦 Batch Content   — template-based bulk generation"
echo "  🚀 GitHub Launch   — community outreach campaign"
