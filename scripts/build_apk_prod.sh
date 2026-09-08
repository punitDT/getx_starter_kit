#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT_DIR"

if [ -f defines.prod.json ]; then
  dart run tools/launch_with_defines.dart --json=defines.prod.json --cmd="flutter build apk --release --no-shrink"
else
  echo "defines.prod.json not found. Create it or use defines.dev.json" >&2
  exit 1
fi
