# hermes-webui-custom

Custom image built on top of `ghcr.io/nesquena/hermes-webui:latest` that adds `git` and the GitHub CLI (`gh`).
Git is preconfigured to use `gh` as its credential helper, so a `GH_TOKEN` in the environment is enough for clone, pull and push over HTTPS.

The included `docker-compose.yml` runs two services:

- `hermes-agent`: the Hermes agent gateway (`nousresearch/hermes-agent:latest`)
- `hermes-webui`: the web UI, built from this repo's `Dockerfile`

All data lives in named volumes (`hermes-home`, `hermes-agent-src`, `hermes-workspace`).

## Deploying on Coolify

1. Create a new resource from this Git repository.
2. Choose the **Docker Compose** build pack.
3. Set the compose location to `/docker-compose.yml`.
4. Add the environment variables below, then deploy.
5. Expose the `hermes-webui` service on port `8787`.

## Environment variables

| Variable | Purpose |
| --- | --- |
| `HERMES_WEBUI_PASSWORD` | Password for logging in to the web UI |
| `API_SERVER_KEY` | Shared key between the web UI and the agent API server |
| `GH_TOKEN` | GitHub token used by `gh` and by git for HTTPS auth |

Never commit real values. Set them only in Coolify (or a local `.env`, which is git-ignored).

## GH_TOKEN warning

Use a **fine-grained** personal access token, scoped as tightly as possible:

- Repository access: only the repositories the agent actually needs
- Permissions: **Contents** read/write and **Pull requests** read/write
- Nothing else

Anything running inside the container can use this token, so treat it as exposed to the agent.
