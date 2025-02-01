#!/bin/sh

case $BLOCK_BUTTON in
  1) pkill -RTMIN+10 dwmblocks
esac

status=$(cat /sys/class/power_supply/BAT1/status)
capacity=$(cat /sys/class/power_supply/BAT1/capacity)

case $status in
  "Full" ) icon="󰁹" ;;
  "Charging" ) icon="󰂄" ;;
  "Discharging" ) icon="󰁿" ;;
esac

echo "$icon $capacity%"

