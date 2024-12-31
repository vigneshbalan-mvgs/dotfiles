#!/bin/bash

# Function to get the current active player
get_current_player() {
  for p in $(playerctl --list-all); do
    if [ -n "$(playerctl --player="$p" metadata --format "{{ title }}")" ]; then
      echo $p
      return
    fi
  done
}

# Function to handle playerctl status or open cmus when clicked
playerctl_status() {
  player=$(get_current_player)

  # If no player is active, show a clickable message to open cmus
  if [ -z "$player" ]; then
    echo "{\"full_text\": \"No player active. Click to open cmus.\", \"color\": \"#ff0000\", \"clickable\": \"true\"}"
    return
  fi

  # Get song metadata when a player is active
  title=$(playerctl --player="$player" metadata --format "{{ title }}")
  artist=$(playerctl --player="$player" metadata --format "{{ artist }}")
  album=$(playerctl --player="$player" metadata --format "{{ album }}")
  status=$(playerctl --player="$player" status)

  # Set the icon and color based on play/pause state
  case "$status" in
  "Playing") icon="▶️" color="#00ff00" ;; # Green for playing
  "Paused") icon="⏸️" color="#ffcc00" ;;  # Yellow for paused
  *) icon="⏹️" color="#ff0000" ;;         # Red for stopped
  esac

  # Output the current song info with artist and album
  echo "{\"full_text\": \"$icon $title - $artist ($album)\", \"color\": \"$color\"}"
}

# Open cmus in Alacritty when clicked
if [ "$1" == "cmus" ]; then
  alacritty -e cmus &
  exit 0
fi

# Run the playerctl_status function
playerctl_status
