#!/usr/bin/env bash
set -euo pipefail

OUT="$HOME/tmp/voice.wav"
TRANSCRIBER="$HOME/Projects/voice-to-text/main.py"
VENV="$HOME/Projects/voice-to-text/bin/activate"

mkdir -p "$HOME/tmp"
rm -f "$OUT"

echo "Recording... Press Ctrl+C to stop."

FFMPEG_PID=""

cleanup() {
  echo
  echo "Stopping recording..."

  # Disable the trap so we don't handle Ctrl+C again.
  trap - INT TERM

  # ffmpeg already received SIGINT from Ctrl+C.
  # Just wait for it to finish writing the WAV header/trailer.
  if [[ -n "$FFMPEG_PID" ]]; then
    wait "$FFMPEG_PID" 2>/dev/null || true
  fi

  if [[ ! -s "$OUT" ]]; then
    echo "Error: recording file was not created."
    exit 1
  fi

  echo "Recording saved to: $OUT"
  echo "Launching transcriber..."

  source "$VENV"
  python3 "$TRANSCRIBER" "$OUT"
  deactivate
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
