echo 'doas setup... Enter the root password'
su -c "xbps-install opendoas && touch /etc/doas.conf && echo 'permit persist :wheel' > /etc/doas.conf"

echo "Installing packages"
doas xbps-install -Su
doas xbps-install dunst libnotify fzf lsd alacritty fastfetch clipmenu flameshot brightnessctl firefox man dmenu rofi xcape setxkbmap feh xorg zsh gtk-engine-murrine neovim pnpm xdg-user-dirs btop mesa-vulkan-radeon ranger bat mpv imv vlc lxappearance qt{5,6}ct tty-clock libX{11,inerama,ft,randr}-devel imlib2-devel curl gpick translate-shell xclip xcursor-themes pulseaudio alsa-plugins-pulseaudio alsa-utils zramen

echo "Installing ueberzugpp"
~/dwm-dots/build/ueberzugpp.sh

echo "Enabling services sddm and zramen"
doas ln -s /etc/sv/sddm /var/service
doas ln -s /etc/sv/zramen /var/service

echo "Copying dwm.desktop for display manager"
doas mkdir -p /usr/share/xsessions
doas cp ~/dwm-dots/build/dwm.desktop /usr/share/xsessions/

echo "Installing Gruvbox-Material theme and JetBrainsMono Nerd Fonts"
git clone https://github.com/TheGreatMcPain/gruvbox-material-gtk.git
doas cp -r ~/gruvbox-material-gtk/themes/Gruvbox-Material-Dark /usr/share/themes
doas cp -r ~/gruvbox-material-gtk/icons/Gruvbox-Material-Dark /usr/share/icons
doas rm -rf gruvbox-material-gtk

doas mkdir -p /usr/share/fonts/nerdfonts
doas cp ~/dwm-dots/build/*.ttf /usr/share/fonts/nerdfonts

echo "Copying configs..."
mkdir ~/.config
cp -r ~/dwm-dots/.config/* ~/.config/
mkdir ~/.local
cp -r ~/dwm-dots/.local/* ~/.local/
sed -i "s/USER/$USER/g" ~/.local/src/slock/config.h
cp ~/dwm-dots/.Xresources ~/
cp ~/dwm-dots/.xprofile ~/
cp ~/dwm-dots/.gtkrc-2.0 ~/
cp -r ~/dwm-dots/wallpaper ~/

echo "Compiling dwm, dwmblocks(bar) and slock(lockscreen)"
(cd ~/.local/src/dwm && make && doas make install)
(cd ~/.local/src/st && make && doas make install)
(cd ~/.local/src/dwmblocks && make && doas make install)
(cd ~/.local/src/slock && make && doas make install)

echo "Configuring Environment..."
echo "QT_QPA_PLATFORMTHEME=qt6ct" | doas tee -a /etc/environment
echo "GTK_THEME=Gruvbox-Material-Dark" | doas tee -a /etc/environment
echo "PATH=/home/$USER/.local/bin" | doas tee -a /etc/environment

echo "Touchpad setup..."
doas mkdir -p /etc/X11/xorg.conf.d
doas ln /usr/share/X11/xorg.conf.d/40-libinput.conf /etc/X11/xorg.conf.d

echo "ZSH setup"
echo "/sbin/zsh" | doas tee -a /etc/shells
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# plugins
#git clone https://github.com/MichaelAquilina/zsh-auto-notify.git $ZSH_CUSTOM/plugins/auto-notify
#git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
#git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
#git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
#git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

