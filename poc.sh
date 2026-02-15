#!/usr/bin/env bash
set -euo pipefail

echo "poc.sh: running at $(pwd)"
echo "poc.sh: HEAD=$(git rev-parse HEAD 2>/dev/null || true)"
