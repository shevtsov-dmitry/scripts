#!/bin/bash

#  INFO:
# Run the --resync command manually for any newly added folder pair:
# EXAMPLE: rclone bisync ~/Pictures/Projects dropbox:Projects --resync
#
# Array of local:remote folder pairs
# Format: "LOCAL_PATH|REMOTE_PATH"
PAIRS=(
  "/mnt/HDD/Documents/training journal|dropbox:training journal"
  # "$HOME/Pictures/Projects|dropbox:Projects"
  # "$HOME/Notes|dropbox:Notes"
)

for pair in "${PAIRS[@]}"; do
  IFS="|" read -r LOCAL REMOTE <<<"$pair"

  echo "Syncing $LOCAL <-> $REMOTE ..."
  /usr/bin/rclone bisync "$LOCAL" "$REMOTE" --verbose --force
done
