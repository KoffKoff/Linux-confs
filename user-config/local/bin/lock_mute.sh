#!/bin/sh

~/.local/bin/spotify-ctl pause
# Check if currently unmuted
wpctl get-volume "@DEFAULT_AUDIO_SINK@" | grep -q '\[MUTED\]'
is_muted=$?
[ $is_muted -ne 0 ] && amixer set Master mute
"$@"
[ $is_muted -ne 0 ] && amixer set Master unmute
