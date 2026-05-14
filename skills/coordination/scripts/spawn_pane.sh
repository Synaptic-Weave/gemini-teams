#!/bin/bash

# gemini-teams: spawn_pane.sh
# Usage: ./spawn_pane.sh <agent_name> <initial_prompt>

AGENT_NAME=$1
INITIAL_PROMPT=$2

if [ -z "$AGENT_NAME" ]; then
  echo "Usage: $0 <agent_name> [initial_prompt]"
  exit 1
fi

PROJECT_NAME=$(basename "$(pwd)")
BUS_ROOT="$HOME/.gemini/com.synapticweave.agent_teams/$PROJECT_NAME"
mkdir -p "$BUS_ROOT"

# Generate unique AGENT_ID
COUNT=$(ls "$BUS_ROOT" | grep -c "^${AGENT_NAME}_[0-9]*.md$")
INSTANCE=$((COUNT + 1))
AGENT_ID="${AGENT_NAME}_${INSTANCE}"
MAILBOX="$BUS_ROOT/${AGENT_ID}.md"
INDEX="$BUS_ROOT/index.md"

# Initialize mailbox
cat <<EOF > "$MAILBOX"
# Mailbox: $AGENT_ID
**Role:** $AGENT_NAME
**Status:** ACTIVE
**Started:** $(date)

---
### Initial Task
$INITIAL_PROMPT
EOF

# Update index.md
if [ ! -f "$INDEX" ]; then
  echo "# Project Team: $PROJECT_NAME" > "$INDEX"
  echo "| Agent ID | Role | Status | Mailbox |" >> "$INDEX"
  echo "| --- | --- | --- | --- |" >> "$INDEX"
fi

echo "| $AGENT_ID | $AGENT_NAME | ACTIVE | [View Mailbox](./${AGENT_ID}.md) |" >> "$INDEX"

# Construct the gemini command
# We use -i for interactive mode
CMD="gemini -i \"@$AGENT_NAME [AGENT_ID: $AGENT_ID] [MAILBOX: $MAILBOX] $INITIAL_PROMPT\""

# Spawn the pane or fallback to background
if [ -n "$TMUX" ]; then
  tmux split-window -h "$CMD"
  echo "Spawned $AGENT_ID in a new tmux pane."
else
  LOG_FILE="$BUS_ROOT/${AGENT_ID}.log"
  echo "Tmux not detected. Falling back to background execution..."
  # Run in background with nohup and redirect output to log
  nohup bash -c "$CMD" > "$LOG_FILE" 2>&1 &
  echo "Spawned $AGENT_ID in the background (PID: $!)."
  echo "Logs available at: $LOG_FILE"
fi

echo "Mailbox: $MAILBOX"
