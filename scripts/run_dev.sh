#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT_DIR"

# Use the Dart launcher to convert JSON to --dart-define flags
if [ -f defines.dev.json ]; then
  dart run tools/launch_with_defines.dart --json=defines.dev.json --cmd="flutter run"
else
  echo "defines.dev.json not found. Create it or use defines.prod.json" >&2
  exit 1
fi
