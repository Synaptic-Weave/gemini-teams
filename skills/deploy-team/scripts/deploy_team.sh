#!/bin/bash

# gemini-teams: deploy_team.sh
# Usage: ./deploy_team.sh <project_path> <project_name> <tech_stack> <description>

PROJECT_PATH=$1
PROJECT_NAME=$2
TECH_STACK=$3
DESCRIPTION=$4

if [ -z "$PROJECT_PATH" ] || [ -z "$PROJECT_NAME" ] || [ -z "$TECH_STACK" ]; then
  echo "Usage: $0 <project_path> <project_name> <tech_stack> [description]"
  exit 1
fi

AGENT_DIR="$PROJECT_PATH/.gemini/agents"
mkdir -p "$AGENT_DIR"

# Path to templates within the extension
# Since this script runs from skills/deploy-team/scripts/, we go up two levels
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_DIR="$(cd "$SCRIPT_DIR/../assets/templates" && pwd)"

echo "Deploying Matrix Team to $PROJECT_NAME..."

for agent_template in "$TEMPLATE_DIR"/*/prompt.md; do
  AGENT_NAME=$(basename "$(dirname "$agent_template")")
  OUTPUT_FILE="$AGENT_DIR/${AGENT_NAME}.md"

  # Read template and replace placeholders
  # We use a simple sed approach for common placeholders
  # Note: In a real scenario, we might want a more robust template engine
  content=$(cat "$agent_template")
  content="${content//{PROJECT_NAME\}/$PROJECT_NAME}"
  content="${content//{PROJECT_DESCRIPTION\}/$DESCRIPTION}"
  content="${content//{TECH_STACK\}/$TECH_STACK}"
  content="${content//{FRONTEND_STACK\}/$TECH_STACK}" # Fallback
  content="${content//{BACKEND_STACK\}/$TECH_STACK}"  # Fallback

  # Append Gemini Teams Coordination Block
  cat <<EOF > "$OUTPUT_FILE"
$content

### Coordination:
You are part of a **Gemini Team**.
- **Mailbox:** Your tasks and messages are in the file path provided in your initial prompt (\`[MAILBOX: ...]\`).
- **Reporting:** Use \`report_back.sh\` to send findings to the coordinator.
- **Collaboration:** Use \`send_message.sh\` to talk to other specialists found in \`index.md\`.
EOF

  echo "  - Deployed @$AGENT_NAME"
done

echo "Team deployment complete."
echo "Run '/agents reload' in the target project to activate your specialists."
