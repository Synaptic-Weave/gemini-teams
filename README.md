# gemini-teams

A specialized skill for [Gemini CLI](https://github.com/google/gemini-cli) that enables multi-agent development using `tmux` panes.

## Overview

`gemini-teams` transforms Gemini CLI into a team coordinator. It allows you to spawn specialized sub-agents (e.g., `@codebase_investigator`, `@security_auditor`) into separate interactive tmux panes. These agents coordinate their work via persistent "mailbox" files in a namespaced global directory, enabling parallel, stateful, and collaborative workflows.

## Features

- **Parallelism:** Run multiple agents simultaneously in your terminal layout.
- **Persistent Mailboxes:** Asynchronous coordination via `~/.gemini/com.synapticweave.agent_teams/`.
- **Peer-to-Peer Messaging:** Agents can communicate with each other directly using namespaced bus files.
- **Tmux Integration:** Native window management and status bar notifications.
- **Full Traceability:** Every task, message, and result is recorded in the agent's specific mailbox file.

## Installation

### Method 1: Direct from GitHub (Recommended)
You can install the skill directly from the repository using the Gemini CLI:

```bash
gemini skills install https://github.com/Synaptic-Weave/gemini-teams --scope user
```

### Method 2: Manual Clone
If you want to modify the skill or install it from a local copy:

1.  **Clone the repo:**
    ```bash
    git clone https://github.com/Synaptic-Weave/gemini-teams.git
    cd gemini-teams
    ```
2.  **Package the skill:**
    ```bash
    gemini skills package .
    ```
3.  **Install the package:**
    ```bash
    gemini skills install gemini-teams.skill --scope user
    ```

### Post-Installation
After installing, you **must** reload your active Gemini session to enable the skill:
```bash
/skills reload
```

## Usage

### As a Coordinator
- **Spawn an agent:** `"Spawn @codebase_investigator to analyze the auth logic."`
- **Follow up:** `"Ask codebase_investigator_1 to look at the database too."`

### As a Specialist (Inside a Pane)
- **Report back:** Use the `report_back.sh` script to send findings to the coordinator.
- **Collaborate:** Use `send_message.sh` to talk to other active agents.

## Project Structure

- `SKILL.md`: The skill definition and instructions.
- `scripts/`:
  - `spawn_pane.sh`: Orchestrates tmux and initializes mailboxes.
  - `send_message.sh`: Facilitates inter-agent messaging.
  - `report_back.sh`: Allows sub-agents to report results.

## License

[MIT](LICENSE)
