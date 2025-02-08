#!/bin/sh

mutestat=$(wpctl get-volume @DEFAULT_SINK@ | grep "MUTED" > /dev/null 2>&1; echo $?)

case $mutestat in
  0) echo " " && exit ;;
esac

vol=$(wpctl get-volume @DEFAULT_SINK@)
vol=$(echo "$vol" | awk '{print $2}')
vol=$(echo "$vol * 100" | bc | awk '{printf "%.0f", $0}')

case 1 in
  $((vol >= 60)) ) icon=" " ;;
  $((vol >= 30)) ) icon=" " ;;
  $((vol >= 1)) ) icon=" " ;;
  * ) echo " " && exit ;;
esac

echo "$icon $vol%"

