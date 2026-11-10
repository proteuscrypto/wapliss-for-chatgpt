#!/usr/bin/env bash
# Builds the ZIP uploaded to platform.openai.com/plugins.
set -euo pipefail
cd "$(dirname "$0")/.."

version=$(python3 -c 'import json; print(json.load(open("plugin.json"))["version"])')
skill_version=$(sed -n 's/^  version: "\(.*\)"/\1/p' skills/wapliss-whatsapp/SKILL.md)
if [ "$version" != "$skill_version" ]; then
  echo "Version mismatch: plugin.json=$version SKILL.md=$skill_version" >&2
  exit 1
fi

python3 -m json.tool plugin.json > /dev/null
python3 -m json.tool mcp.json > /dev/null

mkdir -p dist
out="dist/wapliss-whatsapp-$version.zip"
rm -f "$out"
zip -r -X "$out" plugin.json mcp.json skills assets LICENSE README.md -x '*.DS_Store'
echo "Built $out"
