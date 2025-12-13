#!/bin/sh

bat=$(cat /sys/class/power_supply/BAT0/capacity)
status=$(cat /sys/class/power_supply/BAT0/status)

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
