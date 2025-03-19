if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#    ███████╗███████╗██╗  ██╗██████╗  ██████╗
#    ╚══███╔╝██╔════╝██║  ██║██╔══██╗██╔════╝
#      ███╔╝ ███████╗███████║██████╔╝██║
#     ███╔╝  ╚════██║██╔══██║██╔══██╗██║
# ██╗███████╗███████║██║  ██║██║  ██║╚██████╗
# ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝

for f in ~/.config/zshrc/*; do 
    if [ ! -d $f ] ;then
        c=`echo $f | sed -e "s=.config/zshrc=.config/zshrc/custom="`
        [[ -f $c ]] && source $c || source $f
    fi
done

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
(( ! ${+functions[p10k]} )) || p10k finalize

# lf() { # lfcd
#     cd "$(command lf -print-last-dir "$@")"
# }

lf() { # ranger cd
    local tempfile=$(mktemp)
    ranger --choosedir="$tempfile" "$@"
    if [[ -f $tempfile ]]; then
        local dest=$(<"$tempfile")
        rm -f "$tempfile"
        if [[ -d $dest ]]; then
            cd "$dest"
        fi
    fi
}

# lf() { # yazi cd
#     local tempfile=$(mktemp)
#     yazi --cwd-file="$tempfile" "$@"
#     if [[ -f $tempfile ]]; then
#         cd "$(cat "$tempfile")"
#         rm -f "$tempfile"
#     fi
# }

alias ls='lsd'
alias la='lsd -la'

bindkey -s '^o' 'lf\n'
