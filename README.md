## Agent-driven development starter

A private starter repository for agent-driven development with VS Code Dev
Containers and reusable agent skills managed by dotagents.

### Development container

Open the repository in VS Code and choose **Dev Containers: Reopen in
Container**. The container provides Node.js 24 and GitHub CLI. The post-create
script enables pnpm, configures Git, prepares dependency volumes, and installs
dependencies when a `package.json` is present. If a lockfile exists, installation
uses the frozen lockfile.

The post-start script installs or refreshes the skills declared in
[agents.toml](agents.toml). Port 5173 is forwarded by default; update
[devcontainer.json](.devcontainer/devcontainer.json) for your project's
development server. The container does not start a server automatically.

If GitHub authentication is unavailable, run `gh auth login`, then
`bash .devcontainer/post-create.sh`. Existing Git identity fields are preserved.

### Agent setup

[AGENTS.md](AGENTS.md) contains repository instructions. The configured shared
skills are `grilling`, `branch-and-pr`, `commit-work`, and
`credential-security`, available to the `vscode` and `pi` targets.

Outside the container, install or refresh these skills with:

```bash
npx --yes @sentry/dotagents@latest --project install
```

Follow the `credential-security` skill when working with secrets. Never read or
print `.env` files or include credential values in logs or captured output.

### First steps

- Replace this README with your project's purpose, setup, and validation steps.
- Update `AGENTS.md` with project-specific conventions.
- Adjust forwarded ports, extensions, and volume names in the dev container as
  needed.
- Add project skills to `agents.toml` and refresh them through the post-start
  script.
