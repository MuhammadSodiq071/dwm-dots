# doas setup
echo 'Enter the root password'
su -c "xbps-install opendoas && touch /etc/doas.conf && echo 'permit persist :wheel' > /etc/doas.conf"

# installing packages
doas xbps-install -Su
doas xbps-install dunst libnotify fzf lsd kitty fastfetch clipmenu flameshot brightnessctl firefox man dmenu rofi xcape setxkbmap feh xorg zsh gtk-engine-murrine neovim pnpm xdg-user-dirs btop mesa-vulkan-radeon ranger bat flatpak mpv imv vlc lxappearance qt{5,6}ct tty-clock libX{11,inerama,ft,randr}-devel imlib2-devel curl gpick translate-shell xclip xcursor-themes

# installing Gruvbox-Material theme
git clone https://github.com/TheGreatMcPain/gruvbox-material-gtk.git
doas cp -r ~/gruvbox-material-gtk/themes/Gruvbox-Material-Dark /usr/share/themes
doas cp -r ~/gruvbox-material-gtk/icons/Gruvbox-Material-Dark /usr/share/icons

# copying configs
cp -r ~/dwm-dots/wallpaper ~/
mkdir ~/.config
cp -r ~/dwm-dots/.config/* ~/.config/
mkdir ~/.local
cp -r ~/dwm-dots/.local/* ~/.local/
cp ~/dwm-dots/.Xresources ~/
cp ~/dwm-dots/.xprofile ~/
cp ~/dwm-dots/.gtkrc-2.0 ~/

# compiling dwm, dwmblocks(bar) and slock(lockscreen)
(cd ~/.local/src/dwm && make && doas make install)
(cd ~/.local/src/dwmblocks && make && doas make install)
(cd ~/.local/src/slock && make && doas make install)

# environment setup
echo "QT_QPA_PLATFORMTHEME=qt6ct" | doas tee -a /etc/environment
echo "GTK_THEME=Gruvbox-Material-Dark" | doas tee -a /etc/environment
echo "PATH=/home/$USER/.local/bin" | doas tee -a /etc/environment

# for touchpad setup
doas mkdir -p /etc/X11/xorg.conf.d
doas ln /usr/share/X11/xorg.conf.d/40-libinput.conf /etc/X11/xorg.conf.d

# zsh setup
echo "/sbin/zsh" | doas tee -a /etc/shells
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/MichaelAquilina/zsh-auto-notify.git $ZSH_CUSTOM/plugins/auto-notify
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cp ~/dwm-dots/.zshrc ~/

