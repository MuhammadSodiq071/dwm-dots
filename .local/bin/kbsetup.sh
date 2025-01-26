#!/bin/sh

# EN/RU
setxkbmap us,ru -option 'grp:win_space_toggle'

# Holding CapsLock => Ctrl
setxkbmap -option ctrl:nocaps

# Tapping CapsLock => Escape
xcape -e 'Control_L=Escape'

# Menu => Super
setxkbmap -option altwin:menu_win

# Insert => CapsLock
xmodmap -e "keycode 118 = Caps_Lock"
xcape -e 'Insert=Caps_Lock'

# TouchPad setup
xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Tapping Enabled" 1
xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Natural Scrolling Enabled" 1

