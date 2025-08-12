#!/bin/sh

# Mutes on before locking, then locks using the cmd passed as arguments, upon unlock,
# unmutes if audio was unmuted before locking. The locking and unmuting forks to
# background in order for any idle process to be able to control screens (dpms).

state_file="${XDG_RUNTIME_DIR:-/tmp}/was_mute"

mute() {
	~/.local/bin/spotify-ctl pause
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

mute
{
	"$@"
	unmute
} &
