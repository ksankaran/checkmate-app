# Checkmate App

One-command setup for [Checkmate](https://github.com/ksankaran/checkmate) — an AI-powered QA testing platform.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) (with Compose v2)
- [Git](https://git-scm.com/)
- An [OpenAI API key](https://platform.openai.com/api-keys)

## Quick Start

```bash
git clone https://github.com/ksankaran/checkmate-app.git
cd checkmate-app
make setup   # clones repos + creates .env
# Edit .env and set your OPENAI_API_KEY
make dev     # builds and starts all services
```

Open **http://localhost:3001** in your browser.

## Architecture

```
┌────────────┐       ┌────────────┐       ┌──────────────────┐
│  Frontend   │──────▶│  Backend   │──────▶│ Playwright HTTP  │
│  (Next.js)  │       │  (FastAPI) │       │ (browser engine) │
│  :3001      │       │  :8000     │       │  :8932           │
└────────────┘       └────────────┘       └──────────────────┘
                           │
                     ┌─────┴─────┐
                     │  SQLite   │
                     │ (default) │
                     └───────────┘
```

## Makefile Commands

| Command            | Description                              |
|--------------------|------------------------------------------|
| `make setup`       | Clone sub-repos and create `.env`        |
| `make dev`         | Build and start all services             |
| `make dev-detached`| Start in background                      |
| `make stop`        | Stop all services                        |
| `make logs`        | Tail logs from all services              |
| `make status`      | Check health of each service             |
| `make update`      | `git pull` in each sub-repo              |
| `make clean`       | Stop services and remove Docker volumes  |

## Using PostgreSQL

To run with PostgreSQL instead of SQLite:

1. Update `DATABASE_URL` in `.env`:
   ```
   DATABASE_URL=postgresql://checkmate:checkmate@postgres:5432/checkmate
   ```
2. Start with the postgres profile:
   ```bash
   docker compose --profile postgres up --build
   ```

## Contributing to Sub-Repos

Each directory (`checkmate/`, `checkmate-ui/`, `playwright-http/`) is a standalone Git repo. To contribute:

1. `cd` into the sub-repo
2. Create a branch, make changes, commit
3. Push and open a PR against the upstream repo

Changes to the wrapper (this repo) are separate from changes to the sub-repos.

## Troubleshooting

**Services won't start**
- Make sure Docker is running: `docker info`
- Check logs: `make logs`

**"OPENAI_API_KEY not set"**
- Edit `.env` and replace the placeholder with your actual key

**Port already in use**
- Stop any local services using ports 3001, 8000, or 8932
- Or change the host ports in `docker-compose.yml`

**Stale code**
- Run `make update` to pull latest changes in all sub-repos
- Then `make dev` to rebuild
