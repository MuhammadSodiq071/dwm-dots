echo "Installing packages"
sudo pacman -S dunst libnotify fzf lsd kitty fastfetch clipmenu flameshot brightnessctl firefox pipewire pipewire-alsa pipewire-pulse opendoas man dmenu rofi xcape xorg-setxkbmap feh xorg telegram-desktop unzip zsh gtk-engine-murrine neovim npm xdg-user-dirs btop vulkan-radeon ranger bat gtk2 gtk3 gtk4 flatpak bluez bluez-utils blueman openssh ssh-tools amd-ucode mpv imv vlc lxappearance qt5ct qt6ct picom

echo "Installing paru and aur packages"
git clone https://aur.archlinux.org/paru-bin.git && (cd paru-bin && makepkg -si) && rm -rf paru-bin
paru
paru -S vscodium-bin dashbinsh tty-clock

echo "Copying dwm.desktop for display manager"
doas mkdir -p /usr/share/xsessions
doas cp ~/dwm-dots/build/dwm.desktop /usr/share/xsessions/

echo "Enabling PipeWire"
systemctl --user enable --now pipewire pipewire-pulse

echo "Installing Gruvbox-Material theme"
git clone https://github.com/TheGreatMcPain/gruvbox-material-gtk.git
doas cp -r ~/gruvbox-material-gtk/themes/Gruvbox-Material-Dark /usr/share/themes
doas cp -r ~/gruvbox-material-gtk/icons/Gruvbox-Material-Dark /usr/share/icons
rm -rf gruvbox-material-gtk

echo "Copying configs"
mkdir ~/wallpaper && ln ~/dwm-dots/wallpaper/* ~/wallpaper
mkdir ~/.config
cp -r ~/dwm-dots/.config/* ~/.config/
mkdir ~/.local
cp -r ~/dwm-dots/.local/* ~/.local/
ln ~/dwm-dots/.Xresources ~/
ln ~/dwm-dots/.xprofile ~/
ln ~/dwm-dots/.gtkrc-2.0 ~/

echo "Compiling dwm, dwmblocks(bar) and slock(lockscreen)"
(cd ~/.local/src/dwm/ && make && sudo make install)
(cd ~/.local/src/dwmblocks/ && make && sudo make install)
(cd ~/.local/src/slock/ && make && sudo make install)

echo "Configuring doas and environment..."
sudo touch /etc/doas.conf
echo "permit persist :wheel" | sudo tee -a /etc/doas.conf
echo "QT_QPA_PLATFORMTHEME=qt6ct" | doas tee -a /etc/environment
echo "GTK_THEME=Gruvbox-Material-Dark" | doas tee -a /etc/environment
echo "PATH=$HOME/.local/bin" | doas tee -a /etc/environment

echo "Setup ZSH"
~/dwm-dots/build/zsh
ln ~/dwm-dots/.zshrc ~/
