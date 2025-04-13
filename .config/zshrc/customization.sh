# oh-myzsh themes: https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(
    git
    auto-notify
    sudo
    web-search
    archlinux
    zsh-autosuggestions
    zsh-syntax-highlighting
    fast-syntax-highlighting
    copyfile
    copybuffer
    dirhistory
)

# Set-up oh-my-zsh
source ~/.oh-my-zsh/oh-my-zsh.sh

# Set-up FZF key bindings (CTRL R for fuzzy history finder)
source <(fzf --zsh)

# zsh history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

