#!/bin/bash

# Define the directory to search for video files
DIRECTORY="${1:-/mnt/others/Videos/}"

# Define the video file extensions to look for
VIDEO_EXTENSIONS="mp4|mkv|avi|mov|flv|wmv"

# Define the path to the Rofi theme file
ROFI_THEME="${2:-$HOME/.config/rofi/config.rasi}"

# Find video files using fd, sort them by modification time, and display them using Rofi
selected_files=$(find "$DIRECTORY" -type f \( -iname "*.mp4" -o -iname "*.mkv" -o -iname "*.avi" -o -iname "*.mov" -o -iname "*.flv" -o -iname "*.wmv" \) -printf '%T@ %p\n' | sort -n -r | cut -d' ' -f2- | rofi -dmenu -i -multi-select -p "Select videos:" -theme "$ROFI_THEME")

# Check if any files were selected
if [ -n "$selected_files" ]; then
  # Open selected files with MPV
  echo "$selected_files" | xargs -d '\n' mpv
else
  echo "No files selected."
fi
