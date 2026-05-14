#!/bin/bash

# gemini-teams: send_message.sh
# Usage: ./send_message.sh <target_agent_id> <message>

TARGET_ID=$1
SHIFTED_ARGS=("${@:2}")
MESSAGE="${SHIFTED_ARGS[*]}"

if [ -z "$TARGET_ID" ] || [ -z "$MESSAGE" ]; then
  echo "Usage: $0 <target_agent_id> <message>"
  exit 1
fi

PROJECT_NAME=$(basename "$(pwd)")
BUS_ROOT="$HOME/.gemini/com.synapticweave.agent_teams/$PROJECT_NAME"
MAILBOX="$BUS_ROOT/${TARGET_ID}.md"

if [ ! -f "$MAILBOX" ]; then
  echo "Error: Mailbox for $TARGET_ID not found at $MAILBOX"
  exit 1
fi

# Append message to mailbox
SENDER_ID=${AGENT_ID:-"Coordinator"}
echo -e "\n---\n### Message from $SENDER_ID ($(date))\n$MESSAGE" >> "$MAILBOX"

# Notify the tmux pane if possible
if [ -n "$TMUX" ]; then
  tmux display-message "New message for $TARGET_ID from $SENDER_ID"
fi

echo "Message sent to $TARGET_ID."
