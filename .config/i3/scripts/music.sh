#!/bin/bash

# Function to get the current active player
function get_current_player() {
  # List all available players
  players=$(playerctl --list-all)

  # Check if any player is playing media
  for player in $players; do
    # Get the title of the current media
    title=$(playerctl --player="$player" metadata --format "{{ title }}")
    if [ -n "$title" ]; then
      echo $player
      return
    fi
  done
}

function playerctl_status() {
  # Get the current active player
  local player=$(get_current_player)

  # If no player is detected, show an error
  if [ -z "$player" ]; then
    echo "{\"full_text\": \"No player active\", \"color\": \"#ff0000\"}"
    return
  fi

  # Get song metadata
  local title=$(playerctl --player="$player" metadata --format "{{ title }}")
  local artist=$(playerctl --player="$player" metadata --format "{{ artist }}")
  local album=$(playerctl --player="$player" metadata --format "{{ album }}")
  local status=$(playerctl --player="$player" status)

  # Set the icon and color based on play/pause state
  if [ "$status" = "Playing" ]; then
    icon="▶️"       # Play icon for playing state
    color="#00ff00" # Green for playing
  elif [ "$status" = "Paused" ]; then
    icon="⏸️"       # Pause icon for paused state
    color="#ffcc00" # Yellow for paused
  else
    icon="⏹️"       # Stop icon for stopped state
    color="#ff0000" # Red for stopped
  fi

  # Output the current song info with artist and album, play/pause, and icon
  echo "{\"full_text\": \"$icon $title - $artist ($album)\", \"color\": \"$color\"}"
}

# Run the function
playerctl_status
