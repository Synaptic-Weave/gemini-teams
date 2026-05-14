# gemini-teams

A comprehensive [Gemini CLI Extension](https://github.com/google/gemini-cli) for multi-agent development using `tmux` panes and persistent coordination.

## Overview

`gemini-teams` transforms Gemini CLI into a team coordinator. It bundles a roster of specialized development agents and a coordination skill that allows you to spawn them into separate interactive tmux panes. These agents collaborate via persistent "mailbox" files in a namespaced global directory, enabling parallel, stateful, and distributed workflows.

## Features

- **Agent Roster:** Includes pre-configured specialists like `@codebase-investigator` and `@security-auditor`.
- **Parallelism:** Run multiple agents simultaneously in your terminal layout.
- **Persistent Mailboxes:** Asynchronous coordination via `~/.gemini/com.synapticweave.agent_teams/`.
- **Peer-to-Peer Messaging:** Agents can communicate with each other directly using namespaced bus files.
- **Tmux Integration:** Native window management and status bar notifications.
- **Automatic Fallback:** Spawns agents as background processes if tmux is not available.

## Installation

### Method 1: Direct from GitHub (Recommended)
You can install the extension directly from the repository:

```bash
gemini extensions install https://github.com/Synaptic-Weave/gemini-teams
```

### Method 2: Developer Link
If you want to modify the agents or the coordination logic locally:

1.  **Clone the repo:**
    ```bash
    git clone https://github.com/Synaptic-Weave/gemini-teams.git
    cd gemini-teams
    ```
2.  **Link the extension:**
    ```bash
    gemini extensions link .
    ```

### Post-Installation
After installing or linking, you **must** reload your active Gemini session to enable the extension's agents and skills:
```bash
/skills reload
```

## Usage

### As a Coordinator
- **Spawn an agent:** `"Spawn @codebase-investigator to analyze the auth logic."`
- **Follow up:** `"Ask codebase_investigator_1 to look at the database too."`

### As a Specialist (Inside a Pane)
- **Report back:** Use the `report_back.sh` script to send findings to the coordinator's mailbox.
- **Collaborate:** Use `send_message.sh` to talk to other active agents found in `index.md`.

## Project Structure

- `gemini-extension.json`: The extension manifest.
- `agents/`: Roster of specialized agent definitions (`.md` files).
- `skills/coordination/`: 
  - `SKILL.md`: The "procedural glue" that teaches agents how to collaborate.
  - `scripts/`: Implementation of spawning, messaging, and reporting logic.

## License

[MIT](LICENSE)
