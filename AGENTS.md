## Repository guidance

Read [README.md](README.md) for setup instructions and follow the repository's
existing architecture, conventions, and validation commands.

- Use the repository's configured package manager and run relevant tests before
  submitting changes.
- Follow the installed `branch-and-pr` and `commit-work` skills when creating
  branches, pull requests, or commits.
- Never read or print `.env` files. Follow the `credential-security` skill when
  working with credentials.
- Shared skills are declared in `agents.toml` and refreshed when the
  development container starts. Do not refresh them on every agent session.
