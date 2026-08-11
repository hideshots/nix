#!/usr/bin/env bash
set -euo pipefail

tmp="$(mktemp --suffix=.png)"
trap 'rm -f "$tmp"' EXIT

region="$(slurp)"
grim -g "$region" "$tmp"

text="$(tesseract "$tmp" stdout --psm 6 2>/dev/null | sed '/^[[:space:]]*$/d')"

printf '%s\n' "$text" | wl-copy

notify-send -i applications-education-mathematics "$(printf '%s' "$text")"
