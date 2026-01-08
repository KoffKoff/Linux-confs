#!/bin/sh

# Makes sure the system is muted on "lock", restores previous state un "unlock".

state_file="${XDG_RUNTIME_DIR:-/tmp}/was_mute"

mute() {
	playerctl -a pause
	# Check if currently unmuted
	if wpctl get-volume "@DEFAULT_AUDIO_SINK@" | grep -q '\[MUTED\]'; then
		: > "$state_file"
	else
		wpctl set-mute "@DEFAULT_AUDIO_SINK@" 1
	fi
}

unmute() {
	if [ -f "$state_file" ]; then
		rm -f "$state_file"
	else
		wpctl set-mute "@DEFAULT_AUDIO_SINK@" 0
	fi
}

case "$1" in
	lock) mute ;;
	unlock) unmute ;;
esac
