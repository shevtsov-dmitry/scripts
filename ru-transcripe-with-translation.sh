#!/usr/bin/env bash
set -euo pipefail

OUT="$HOME/tmp/voice.wav"

TRANSCRIBER="$HOME/Projects/voice-to-text-ru/main.py"
TRANSCRIBER_VENV="$HOME/Projects/voice-to-text-ru/bin/activate"

TRANSLATOR="$HOME/Projects/translator-ru-to-en/main.py"
TRANSLATOR_VENV="$HOME/Projects/translator-ru-to-en/bin/activate"

mkdir -p "$HOME/tmp"
rm -f "$OUT"

FFMPEG_PID=""

echo "Recording... Press Ctrl+C to stop." >&2

cleanup() {
  trap - INT TERM

  echo "Stopping recording..." >&2

  if [[ -n "$FFMPEG_PID" ]] && kill -0 "$FFMPEG_PID" 2>/dev/null; then
    # Gracefully stop FFmpeg.
    kill -INT "$FFMPEG_PID" 2>/dev/null || true

    # Wait until FFmpeg finalizes the WAV.
    wait "$FFMPEG_PID" 2>/dev/null || true
  fi

  FFMPEG_PID=""

  if [[ ! -s "$OUT" ]]; then
    echo "ERROR: Recording file was not created." >&2
    exit 1
  fi

  # --------------------------------------------------
  # STEP 1: Russian transcription
  # --------------------------------------------------

  echo "Transcribing..." >&2

  source "$TRANSCRIBER_VENV"

  TEXT="$(python3 "$TRANSCRIBER" "$OUT")"

  deactivate

  if [[ -z "$TEXT" ]]; then
    echo "ERROR: Transcription returned empty text." >&2
    exit 1
  fi

  # --------------------------------------------------
  # STEP 2: Russian -> English translation
  # --------------------------------------------------

  echo "Translating to English..." >&2

  source "$TRANSLATOR_VENV"

  TRANSLATED_TEXT="$(
    printf '%s' "$TEXT" | python3 "$TRANSLATOR" --stdin
  )"

  deactivate

  if [[ -z "$TRANSLATED_TEXT" ]]; then
    echo "ERROR: Translation returned empty text." >&2
    exit 1
  fi

  # --------------------------------------------------
  # STEP 3: Output and clipboard
  # --------------------------------------------------

  printf '%s\n' "$TRANSLATED_TEXT"

  printf '%s' "$TRANSLATED_TEXT" | wl-copy

  echo "English translation copied to clipboard." >&2
}

trap cleanup INT TERM

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
