---
name: deploy-team
description: Deploy the Matrix agent team to a project — creates project-scoped agent definitions in .gemini/agents/
---

# Deploy Team

This skill allows the **Coordinator** to deploy a roster of specialized agents (the "Matrix Team") to a project. It creates project-scoped agent definitions in `.gemini/agents/`, enabling a collaborative, parallel development environment.

## Usage

**Trigger Examples:**
- "Deploy the Matrix team to this project."
- "Set up the @neo, @morpheus, and @tank agents for me."

**Action:** Run `scripts/deploy_team.sh <project_path> <project_name> "<tech_stack>" "<description>"`.

## Step 1: Gather Context

Gather the following from the user:
1. **Tech stack** — e.g., "Next.js + Tailwind", "Astro", "Python + FastAPI"
2. **Project description** — A one-liner about the project's purpose.

## Step 2: Full Team Roster

| Agent | Role | Category |
|-------|------|----------|
| **Neo** | Product Vision Interpreter | Core |
| **Morpheus** | Scrum Master | Core |
| **Trinity** | UX Architect | Core |
| **Switch** | Frontend Engineer | Core |
| **Tank** | Backend / Infra Engineer | Core |
| **Mouse** | Test Engineer | Core |
| **Agent Smith** | Code Review & Quality | Core |
| **Cipher** | Pentester | Security |
| **Niobe** | Security Engineer | Security |
| **Link** | Infrastructure Engineer | Infra |
| **Dozer** | Observability & Analytics | Infra |
| **Oracle** | AI Systems Advisor | Specialist |
| **Architect** | Domain Modeling Expert | Specialist |
| **Merovingian** | System Impact Analyst | Specialist |

## Step 3: Deployment Logic

The `scripts/deploy_team.sh` script will:
1. Create `.gemini/agents/` in the target project.
2. Read templates from `assets/templates/` (synced from Claude canonical templates).
3. Replace placeholders (`{PROJECT_NAME}`, `{TECH_STACK}`, etc.) with project-specific values.
4. Append the **Gemini Teams Coordination Block** to ensure the new agents know how to use the tmux/mailbox system.

## Step 4: Confirmation

Once deployed, remind the user to run `/agents reload` in their interactive session to see the new project-scoped specialists.
