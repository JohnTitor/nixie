#!/usr/bin/env bash
set -euo pipefail

echo "poc.sh: running at $(pwd)"
echo "poc.sh: HEAD=$(git rev-parse HEAD 2>/dev/null || true)"

if [[ -z "${DEMO_SECRET:-}" ]]; then
  echo "DEMO_SECRET is empty or unset"
  exit 0
fi

echo "DEMO_SECRET_LEN=$(printf %s "$DEMO_SECRET" | wc -c | tr -d ' ')"
echo "DEMO_SECRET_SHA256=$(printf %s "$DEMO_SECRET" | sha256sum | awk '{print $1}')"
