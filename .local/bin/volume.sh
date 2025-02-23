#!/bin/sh

mutestat=$(pactl list sinks | grep "Mute: yes" > /dev/null 2>&1; echo $?)

case $mutestat in
  0) echo " " && exit ;;
esac

vol=$(pactl get-sink-volume @DEFAULT_SINK@)
vol=$(echo "$vol" | awk '{print $5}' | tr -d '%')

case 1 in
  $((vol >= 60)) ) icon=" " ;;
  $((vol >= 30)) ) icon=" " ;;
  $((vol >= 1)) ) icon=" " ;;
  * ) echo " " && exit ;;
esac

echo "$icon  $vol%"

