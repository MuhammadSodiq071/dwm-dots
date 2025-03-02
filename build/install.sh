# installing packages
sudo pacman -S dunst libnotify fzf lsd kitty fastfetch clipmenu flameshot brightnessctl firefox pipewire pipewire-alsa pipewire-pulse opendoas man dmenu rofi xcape xorg-setxkbmap feh xorg telegram-desktop unzip zsh gtk-engine-murrine neovim npm xdg-user-dirs btop vulkan-radeon ranger bat gtk2 gtk3 gtk4 flatpak bluez bluez-utils blueman openssh ssh-tools amd-ucode mpv imv vlc lxappearance qt5ct qt6ct picom

# enable pipewire
systemctl --user enable --now pipewire pipewire-pulse

# installing paru and aur packages
git clone https://aur.archlinux.org/paru-bin.git && (cd paru-bin && makepkg -si) && rm -rf paru-bin
paru
paru -S vscodium-bin dashbinsh tty-clock

# installing Gruvbox-Material theme
git clone https://github.com/TheGreatMcPain/gruvbox-material-gtk.git
doas cp -r ~/gruvbox-material-gtk/themes/Gruvbox-Material-Dark /usr/share/themes
doas cp -r ~/gruvbox-material-gtk/icons/Gruvbox-Material-Dark /usr/share/icons
rm -rf gruvbox-material-gtk

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
(cd ~/.local/src/dwm/ && make && sudo make install)
(cd ~/.local/src/dwmblocks/ && make && sudo make install)
(cd ~/.local/src/slock/ && make && sudo make install)

# doas and environment
sudo touch /etc/doas.conf
echo "permit persist :wheel" | sudo tee -a /etc/doas.conf
echo "QT_QPA_PLATFORMTHEME=qt6ct" | doas tee -a /etc/environment
echo "GTK_THEME=Gruvbox-Material-Dark" | doas tee -a /etc/environment
echo "PATH=/home/$USER/.local/bin" | doas tee -a /etc/environment

# setup zsh
echo "/sbin/zsh" | doas tee -a /etc/shells
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/MichaelAquilina/zsh-auto-notify.git $ZSH_CUSTOM/plugins/auto-notify
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
cp ~/dwm-dots/.zshrc ~/

