#!/bin/sh

option=$(printf "   Shutdown\n   Reboot\n   Lock" | rofi -dmenu -p 'Power Menu' -i -theme powermenu)

case "$option" in
  "   Shutdown") poweroff ;;
  "   Reboot") reboot ;;
  "   Lock") slock ;;
  *) exit 0 ;;
esac

