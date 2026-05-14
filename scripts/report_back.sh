#!/bin/bash

# gemini-teams: report_back.sh
# Usage: ./report_back.sh <result_summary>

RESULT_SUMMARY="$*"

if [ -z "$MAILBOX" ]; then
  echo "Error: MAILBOX environment variable not set. Are you running inside an agent pane spawned by gemini-teams?"
  exit 1
fi

if [ -z "$RESULT_SUMMARY" ]; then
  echo "Usage: $0 <result_summary>"
  exit 1
fi

# Append result to mailbox
echo -e "\n---\n### Result/Report ($(date))\n$RESULT_SUMMARY" >> "$MAILBOX"

# Notify via tmux
tmux display-message "Agent ${AGENT_ID:-"Unknown"} reported back."

echo "Reported back to mailbox: $MAILBOX"
