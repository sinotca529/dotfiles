if [[ "$ZPROF" = true ]]; then
    zmodload zsh/zprof
fi

bindkey -e
export WORDCHARS='*?_.[]~-=&;!#$%^(){}<>'
setopt globdots

autoload -Uz colors && colors        # 色
autoload -U compinit && compinit     # 補完
autoload -Uz bracketed-paste-magic   # bracketed paste
zle -N bracketed-paste bracketed-paste-magic

# General
HISTFILE=~/.zsh_history     # コマンド履歴の保存先
HISTSIZE=100000             # メモリ上に記憶する履歴数
SAVEHIST=100000             # ファイルに保存する履歴数
setopt share_history        # 同時に起動したzshでhistoryを共有
setopt no_beep              # ビープ音オフ
[ -t 0 ] && stty stop undef # stdin が空いているときは ^S を無効化

# Alias
alias ls='ls --color=auto'
alias sl='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias tmux='tmux -u'
alias lg='lazygit'
alias nv=nvim
alias manjp='LC_ALL=ja_JP.UTF-8 man'
alias mv='mv -i'

# Env val
export LS_COLORS=$LS_COLORS:'di=0;36:ow=0;36'
export EDITOR=nvim
export PATH=~/tools:~/go/bin:$PATH:/usr/local/go/bin:~/tools/lazydocker
export LC_ALL=C.UTF-8

# Load plugins.
PLUGMAN=~/dotfiles/zsh/.zsh/plugman.sh
if [ -e $PLUGMAN ]; then
    source $PLUGMAN
    plugman plug "zsh-users/zsh-autosuggestions"
    plugman plug "zsh-users/zsh-syntax-highlighting"
    ZSH_HIGHLIGHT_STYLES[comment]='fg=white'
    ZSH_HIGHLIGHT_STYLES[globbing]='fg=cyan'
    plugman_unset
else
    echo "WARN : Plugin manager does not exist."
fi
unset PLUGMAN

#------------------------
# Rust
#------------------------
source ~/.cargo/env

#------------------------
# NPM
#------------------------
NPM_PACKAGES=${HOME}/.npm-packages
NODE_PATH=${NPM_PACKAGES}/lib/node_modules:$NODE_PATH
PATH=${NPM_PACKAGES}/bin:$PATH
# Unset manpath so we can inherit from /etc/manpath via the `manpath`
# command
unset MANPATH # delete if you already modified MANPATH elsewhere in your config
MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

#------------------------
# Machine specific settings
#------------------------
if [ -e ${HOME}/.additional.sh ]; then
    source ${HOME}/.additional.sh
fi

function dict() {
    if echo $1 | grep -q '\<[0-9A-Za-z]'; then
        grep ^$1 ~/tools/dict/gene.utf8 -A 1 -wi --color
    else
        grep ^$1 ~/tools/dict/edict.utf8 -wi --color
    fi
}

function timezsh() {
    for i in $(seq 1 10); do time zsh -i -c exit; done
}

function profzsh() {
    ZPROF=true zsh -i -c exit
}

function tmp() {
    echo $1
    A="${1#*/}"
    echo $A
}

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
# PATH=$(awk '!a[$0]++{print}' RS=: ORS=: <<< "$PATH" | sed 's/:$/\n/')

PATH=~/.local/bin:$PATH

function conf() {
    case $1 in
        "nvim") nvim -c 'cd ~/dotfiles/nvim/.config/nvim' ~/dotfiles/nvim/.config/nvim ;;
        "tmux") nvim -c 'cd ~/dotfiles/tmux' ~/dotfiles/tmux/.tmux.conf ;;
        "zsh") nvim -c 'cd ~/dotfiles/zsh' ~/dotfiles/zsh/.zshrc ;;
        * ) nvim -c 'cd ~/dotfiles' ~/dotfiles ;;
    esac
}

function run-sway() {
    export XDG_CURRENT_DESKTOP=sway
    export XDG_SESSION_DESKTOP=sway
    export XDG_SESSION_TYPE=wayland
    export XMODIFIERS=@im=fcitx
    export GTK_IM_MODULE=fcitx
    export QT_IM_MODULE=fcitx
    export MOZ_ENABLE_WAYLAND=1
    sway
}
if [ -z "$TMUX$ZELLIJ$VIM" ]; then
    if [[ -n "$(tmux list-sessions 2>/dev/null)" ]]; then
            tmux a
    else
        tmux
    fi
fi

if [[ "$ZPROF" = true ]]; then
    zprof
fi
