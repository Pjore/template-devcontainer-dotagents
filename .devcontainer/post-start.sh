#!/bin/bash
set -euo pipefail

WORKSPACE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$WORKSPACE_DIR"

echo "Refreshing agent skills..."
npx --yes @sentry/dotagents@latest --project install

echo "Post-start setup complete."
