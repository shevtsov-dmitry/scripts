#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: kinokino <URL>" >&2
  exit 1
fi

url="${1//kinopoisk.ru/kinokino.win}"

if ! command -v wl-copy >/dev/null 2>&1; then
  echo "Error: wl-copy is required (install wl-clipboard)." >&2
  exit 1
fi

printf '%s\n' "$url" | wl-copy
printf '%s\n' "$url"
