#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT_DIR"

ENV_FILE="environments/dev.json"
if [ ! -f "$ENV_FILE" ]; then
  echo "Missing $ENV_FILE. Create it with your defines (e.g. BASE_URL, API_KEY)." >&2
  exit 1
fi

echo "Building debug APK using $ENV_FILE"
dart run tools/launch_with_defines.dart --json="$ENV_FILE" --cmd="flutter build apk --debug"
