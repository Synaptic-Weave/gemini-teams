---
name: gemini-teams
description: Enables multi-agent development using tmux panes. Use this to spawn specialized sub-agents (e.g., @codebase_investigator) in separate interactive panes, coordinate their work via persistent mailboxes in ~/.gemini/com.synapticweave.agent_teams/, and enable peer-to-peer messaging between agents.
---

# Gemini Teams

This skill allows you to act as a **Coordinator** for a team of specialized agents running in parallel `tmux` panes. It uses a namespaced "bus" directory to manage communication and task persistence.

## Core Workflow

### 1. Spawning a Specialist
When you need a specialized agent to work on a task in parallel, use the `spawn_pane.sh` script.

**Trigger Examples:**
- "Spawn @codebase_investigator to analyze the auth flow in a new pane."
- "Open a new pane for @security_auditor to check for vulnerabilities."

**Action:** Run `scripts/spawn_pane.sh <agent_name> "<initial_prompt>"`.

### 2. Messaging & Follow-up
You can send new tasks or queries to already active agents using `scripts/send_message.sh`.

**Trigger Examples:**
- "Ask codebase_investigator_1 to look at the database schema too."
- "Send a message to security_auditor_1: 'Found a potential leak in session.ts, please verify'."

**Action:** Run `scripts/send_message.sh <agent_id> "<message>"`.

### 3. Reporting Back
If you are running inside a spawned pane, use `scripts/report_back.sh` to send your findings back to the coordinator's mailbox.

**Action:** Run `scripts/report_back.sh "<summary_of_findings>"`.

## Coordination Infrastructure

All coordination data is stored in:
`~/.gemini/com.synapticweave.agent_teams/<project_name>/`

- **`index.md`**: The team registry. Check this to see active agents and their IDs.
- **`<agent_id>.md`**: The persistent mailbox for a specific agent instance.

## Guidelines for Agents

- **As a Coordinator:**
  - Maintain the high-level goal.
  - Delegate deep analysis or repetitive tasks to specialized panes.
  - Periodically check the `index.md` and agent mailboxes for results.
  
- **As a Specialist (in a spawned pane):**
  - Focus on your specific domain.
  - Keep your mailbox open (you can read it with `read_file`) to check for incoming messages.
  - Use `report_back.sh` to signal completion or provide major updates.
  - You can use `send_message.sh` to talk to other peers listed in `index.md`.

## Tmux vs. Background Mode
While this skill is optimized for `tmux`, it will automatically fall back to **Background Mode** if tmux is not detected.

- **Tmux Mode:** Opens a new interactive pane for the agent.
- **Background Mode:** Spawns the agent as a background process. Output is redirected to a `.log` file in the bus directory. Use this when you want agents to work asynchronously without occupying terminal space.
