#!/bin/sh

bat_path='/sys/class/power_supply/BAT0'

if ! [ -d "$bat" ]; then
	exit
fi

bat=$(cat "$bat_path/capacity")
status=$(cat "$bat_path/status")

case "$status" in
	Full|Charging) echo " $bat%"; exit;;
	Discharging|"Not charging") :;;
	*) echo "Unkown status: '$status'"; exit;;
esac

case "$bat" in
	?|1?) bat=" $bat%";;
	2?|3?) bat=" $bat%";;
	4?|5?) bat=" $bat%";;
	6?|7?) bat=" $bat%";;
	8?|9?|100) bat=" $bat%";;
	*) bat="Unkown bat: '$bat'";;
esac

echo "$bat"
