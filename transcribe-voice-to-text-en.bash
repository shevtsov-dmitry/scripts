#!/usr/bin/env bash
set -euo pipefail

OUT="$HOME/tmp/voice.wav"
TRANSCRIBER="$HOME/Projects/voice-to-text-en/main.py"
VENV="$HOME/Projects/voice-to-text-en/bin/activate"

mkdir -p "$HOME/tmp"
rm -f "$OUT"

FFMPEG_PID=""

echo "Recording... Press Ctrl+C to stop." >&2

cleanup() {
  trap - INT TERM

  echo "Stopping recording..." >&2

  if [[ -n "$FFMPEG_PID" ]] && kill -0 "$FFMPEG_PID" 2>/dev/null; then
    # FFmpeg is in its own session, so Ctrl+C did not reach it.
    # Send it one graceful SIGINT now.
    kill -INT "$FFMPEG_PID" 2>/dev/null || true

    # Wait until FFmpeg has completely finalized the WAV.
    wait "$FFMPEG_PID" 2>/dev/null || true
  fi

  FFMPEG_PID=""

  if [[ ! -s "$OUT" ]]; then
    echo "ERROR: Recording file was not created." >&2
    exit 1
  fi

  echo "Transcribing..." >&2

  source "$VENV"

  TEXT="$(python3 "$TRANSCRIBER" "$OUT")"

  deactivate

  printf '%s\n' "$TEXT"
  printf '%s' "$TEXT" | wl-copy

  echo "Text copied to clipboard." >&2
}

trap cleanup INT TERM

# Optimized option for better voice recognition for the AI
setsid ffmpeg \
  -hide_banner \
  -loglevel error \
  -f pulse \
  -i default \
  -ac 1 \
  -ar 16000 \
  -af "highpass=f=70,lowpass=f=7600" \
  -c:a pcm_s16le \
  "$OUT" &

FFMPEG_PID=$!

wait "$FFMPEG_PID"
