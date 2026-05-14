# Matrix Agent Team Templates

Canonical, project-agnostic prompt templates for the Matrix development team.

## Usage

When deploying a new project with `/deploy-team`:
1. Read the relevant agent templates from this directory
2. Replace all `{PLACEHOLDER}` variables with project-specific values
3. Write adapted prompts to `~/.claude/projects/{project-path}/memory/agents/{agent}/prompt.md`

## Placeholder Variables

| Variable | Description |
|----------|-------------|
| `{PROJECT_NAME}` | Full project name (e.g., "Synaptic Weave Academy") |
| `{PROJECT_DESCRIPTION}` | One-line description of what the project does |
| `{FRONTEND_STACK}` | Frontend framework and key libraries |
| `{BACKEND_STACK}` | Backend framework, runtime, and key libraries |
| `{DB_STACK}` | Database and ORM |
| `{AUTH_MECHANISM}` | Auth approach (e.g., "JWT custom", "Clerk", "Auth0") |
| `{CLOUD_PROVIDER}` | Cloud provider and key services used |
| `{MONOREPO_STRUCTURE}` | Key directories and their purposes |
| `{DATA_ISOLATION_KEY}` | Primary data isolation field (e.g., `workspace_id`, `user_id`, `tenant_id`) |
| `{PERSONA_1/2/3}` | Primary user personas with names and pain points |
| `{DOMAIN_ENTITIES}` | Key domain entities and their archetypes |
| `{TEST_RUNNER}` | Test framework and run commands |
| `{CI_CD_PLATFORM}` | CI/CD platform (e.g., "GitHub Actions") |

## Agent Roster

| Agent | Model | Role |
|-------|-------|------|
| Neo | opus | Product Vision Interpreter |
| Morpheus | opus | Scrum Master |
| Trinity | opus | UX Architect |
| Switch | sonnet | Frontend Engineer (Lead) |
| Tank | sonnet | Backend Engineer (Lead) |
| Mouse | sonnet | Test Engineer |
| Smith | sonnet | Code Reviewer |
| Ghost | sonnet | Full-Stack Developer |
| Apoc | sonnet | Full-Stack Developer |
| Cipher | opus | Pentester |
| Niobe | sonnet | Security Engineer |
| Link | sonnet | Infrastructure Engineer |
| Dozer | sonnet | Observability & Analytics |
| Oracle | opus | AI Systems Advisor |
| Architect | opus | Domain Modeling Expert |
| Merovingian | sonnet | System Impact Analyst |
