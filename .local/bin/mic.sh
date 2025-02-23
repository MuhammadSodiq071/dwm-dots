#!/bin/sh

mutestat=$(pactl list sources | grep "Mute: yes" > /dev/null 2>&1; echo $?)

case $mutestat in
  0) echo 󰍭 && exit ;;
esac

vol=$(pactl get-source-volume @DEFAULT_SOURCE@)
vol=$(echo "$vol" | awk '{print $5}' | tr -d '%')

case 1 in
  $((vol >= 1)) ) icon="󰍬" ;;
  * ) echo 󰍭 && exit ;;
esac

echo "$icon $vol%"

