[ -f ~/.Xresources ] && xrdb ~/.Xresources
[ -f ~/.xprofile ] && . ~/.xprofile
exec dwm
