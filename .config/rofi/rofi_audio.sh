#!/bin/bash

# Define the directory to search for audio files
DIRECTORY="${1:-$HOME}"

# Define the audio file extensions to look for
AUDIO_EXTENSIONS="mp3|wav|flac|aac|ogg|m4a"

# Define the path to the Rofi theme file
ROFI_THEME="${2:-$HOME/.config/rofi/config.rasi}"

# Find audio files using fd and display them using Rofi
selected_files=$(fd --extension mp3 --extension wav --extension flac --extension aac --extension ogg --extension m4a . "$DIRECTORY" | rofi -dmenu -i -multi-select -p "Select audio:" -theme "$ROFI_THEME")

# Check if any files were selected
if [ -n "$selected_files" ]; then
	# Open cmus and clear the current playlist
	cmus-remote -C "clear"

	# Add selected files to cmus playlist
	echo "$selected_files" | while IFS= read -r file; do
		cmus-remote -C "add \"$file\""
	done

	# Start playing the first selected file
	cmus-remote -C "play"
else
	echo "No files selected."
fi
