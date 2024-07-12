#!/bin/bash

# Define the directory to search for video files
DIRECTORY="${1:-$HOME}"

# Define the video file extensions to look for
VIDEO_EXTENSIONS="mp4|mkv|avi|mov|flv|wmv"

# Define the path to the Rofi theme file
ROFI_THEME="${2:-$HOME/.config/rofi/config.rasi}"

# Find video files using fd and display them using Rofi
selected_files=$(fd --extension mp4 --extension mkv --extension avi --extension mov --extension flv --extension wmv . "$DIRECTORY" | rofi -dmenu -i -multi-select -p "Select videos:" -theme "$ROFI_THEME")

# Check if any files were selected
if [ -n "$selected_files" ]; then
	# Open selected files with MPV
	echo "$selected_files" | xargs -d '\n' mpv
else
	echo "No files selected."
fi
