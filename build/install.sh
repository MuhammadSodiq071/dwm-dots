sudo pacman -S dunst libnotify fzf lsd kitty fastfetch ueberzugpp clipmenu flameshot brightnessctl firefox pipewire pipewire-alsa pipewire-pulse opendoas man dmenu rofi xcape xorg-setxkbmap feh xorg telegram-desktop unzip zsh gtk-engine-murrine neovim npm xdg-user-dirs btop vulkan-radeon ranger bat gtk2 gtk3 gtk4 flatpak bluez bluez-utils blueman ssh-tools amd-ucode mpv imv vlc

git clone https://aur.archlinux.org/paru-bin.git && cd paru-bin && makepkg -si && cd .. && rm -rf paru-bin

paru
paru -S vscodium-bin dashbinsh tty-clock

~/dwm-dots/build/themes/install.sh

cp -r ~/dwm-dots/wallpaper ~/
mkdir ~/.config
cp -r ~/dwm-dots/.config/* ~/.config/
cp ~/dwm-dots/.config/* ~/.config/
mkdir ~/.local
cp -r ~/dwm-dots/.local/* ~/.local/
cp ~/dwm-dots/.Xresources ~/
cp ~/dwm-dots/.xprofile ~/
cp ~/dwm-dots/.gtkrc-2.0 ~/
(cd ~/.local/src/dwm/ && make && sudo make install)
(cd ~/.local/src/dwmblocks/ && make && sudo make install)
(cd ~/.local/src/slock/ && make && sudo make install)

sudo touch /etc/doas.conf
sudo echo "permit persist :wheel" >> /etc/doas.conf
doas echo "QT_QPA_PLATFORMTHEME=qt6ct" >> /etc/environment
doas echo "GTK_THEME=Arc-Dark" >> /etc/environment
doas echo "GOPATH=/opt/go" >> /etc/environment
doas echo "PATH=/home/muhammadsodiq/.local/bin" >> /etc/environment

doas echo "/sbin/zsh" >> /etc/shells
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/MichaelAquilina/zsh-auto-notify.git $ZSH_CUSTOM/plugins/auto-notify
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
cp ~/dwm-dots/.zshrc ~/

