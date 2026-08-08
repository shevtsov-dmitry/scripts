#!/usr/bin/env bash
set -euo pipefail

# TODO make full compatibility by automatically download repo and model on new system

OUT="$HOME/tmp/voice.wav"
TRANSCRIBER="$HOME/Projects/voice-to-text/main.py"
VENV="$HOME/Projects/voice-to-text/bin/activate"

mkdir -p "$HOME/tmp"
rm -f "$OUT"

echo "Recording..." >&2

FFMPEG_PID=""

cleanup() {
  trap - INT TERM

  echo "Stopping recording..." >&2

  if [[ -n "$FFMPEG_PID" ]]; then
    wait "$FFMPEG_PID" 2>/dev/null || true
  fi

  if [[ ! -s "$OUT" ]]; then
    echo "ERROR: Recording file was not created." >&2
    exit 1
  fi

  echo "Transcribing..." >&2

  source "$VENV"

  TEXT="$(python3 "$TRANSCRIBER" "$OUT")"

  deactivate

  # Print exactly what Python returned.
  printf '%s\n' "$TEXT"

  # Copy exactly the same text to the Wayland clipboard.
  printf '%s' "$TEXT" | wl-copy

  echo "Text copied to clipboard." >&2
}

trap cleanup INT TERM

ffmpeg \
  -hide_banner \
  -loglevel error \
  -f pulse \
  -i default \
  -ar 16000 \
  -ac 1 \
  -c:a pcm_s16le \
  "$OUT" &

FFMPEG_PID=$!

wait "$FFMPEG_PID"
