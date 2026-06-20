#!/usr/bin/env bash
# Start the claude-usage Docker container with the Claude Code OAuth token
# extracted from the macOS Keychain so the usage-limits gauges work inside the container.
# Also writes .env so plain `docker compose` picks up the token too.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

TOKEN=$(security find-generic-password -s "Claude Code-credentials" -w 2>/dev/null \
  | python3 -c "import sys,json; print(json.load(sys.stdin)['claudeAiOauth']['accessToken'])" \
  2>/dev/null || true)

if [ -z "$TOKEN" ]; then
  echo "Warning: could not read Claude Code token from Keychain — usage-limits gauges will be unavailable." >&2
else
  echo "CLAUDE_ACCESS_TOKEN=$TOKEN" > "$SCRIPT_DIR/.env"
fi

docker compose -f "$SCRIPT_DIR/docker-compose.yml" "$@"
