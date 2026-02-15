#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 3 ]]; then
  echo "usage: $0 <owner> <repo> <sha>" >&2
  exit 2
fi

owner="$1"
repo="$2"
sha="$3"
event_type="demo.dispatch"

token="${GH_TOKEN:-${GITHUB_TOKEN:-}}"
if [[ -z "$token" ]]; then
  echo "Set GH_TOKEN (or GITHUB_TOKEN) to a token that can call the dispatch API for ${owner}/${repo}." >&2
  exit 1
fi

api="https://api.github.com/repos/${owner}/${repo}/dispatches"
payload="{\"event_type\":\"${event_type}\",\"client_payload\":{\"sha\":\"${sha}\"}}"

curl -sS -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer ${token}" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  "$api" \
  -d "$payload" >/dev/null

echo "Dispatched ${event_type} to ${owner}/${repo} for sha=${sha}"
