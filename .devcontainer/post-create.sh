#!/bin/bash
set -euo pipefail

WORKSPACE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$WORKSPACE_DIR"

echo "Configuring Git..."
git config --global --add safe.directory "$WORKSPACE_DIR"

if ! git config --get user.name >/dev/null || ! git config --get user.email >/dev/null; then
    if GITHUB_IDENTITY="$(gh api user --jq '[.name // .login, .email // ((.id | tostring) + "+" + .login + "@users.noreply.github.com")] | @tsv')"; then
        IFS=$'\t' read -r GITHUB_NAME GITHUB_EMAIL <<< "$GITHUB_IDENTITY"
        if ! git config --get user.name >/dev/null; then
            git config --local user.name "$GITHUB_NAME"
        fi
        if ! git config --get user.email >/dev/null; then
            git config --local user.email "$GITHUB_EMAIL"
        fi
    else
        echo "WARNING: Git identity unavailable. Run gh auth login, then bash .devcontainer/post-create.sh to retry." >&2
    fi
fi

echo "Preparing dependency volumes and pnpm..."
sudo -n chown -R node:node "$WORKSPACE_DIR/node_modules" /pnpm/store
sudo -n corepack enable pnpm
corepack prepare pnpm@latest --activate
pnpm config set store-dir /pnpm/store

if [[ -f package.json ]]; then
    echo "Installing dependencies..."
    if [[ -f pnpm-lock.yaml ]]; then
        pnpm install --frozen-lockfile
    else
        pnpm install
    fi
else
    echo "No package.json; skipping dependency installation."
fi

echo "Post-create setup complete."
