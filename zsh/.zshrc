bindkey -e
export WORDCHARS='*?_.[]~-=&;!#$%^(){}<>'

#------------------------
# Color
#------------------------
# 色を使用
autoload -Uz colors && colors
# 各コマンドで色を使う
export LS_COLORS=$LS_COLORS:'di=0;36:ow=0;36'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

#------------------------
# History
#------------------------
# 保存先
HISTFILE=~/.zsh_history
# メモリ上に記憶するエントリ数
HISTSIZE=100000
# ファイルに保存するエントリ数
SAVEHIST=100000
# 同時に起動したzshでhistoryを共有
setopt share_history

# 補完を有効化
autoload -U compinit && compinit

# ビープ音オフ
setopt no_beep

# エディタをneovimに
export EDITOR=nvim

# カーソルを線に
#echo '\e[5 q'

#------------------------
# Plugin
#------------------------
# Load plugins.
PLUGMAN=~/dotfiles/zsh/.zsh/plugman.sh
if [ -e $PLUGMAN ]; then
    source $PLUGMAN
    plugman plug "zsh-users/zsh-autosuggestions"
    plugman plug "zsh-users/zsh-syntax-highlighting"
    ZSH_HIGHLIGHT_STYLES[comment]='fg=white'
    plugman_unset
else
    echo "WARN : Plugin manager does not exist."
fi
unset PLUGMAN


#------------------------
# Alias
#------------------------
alias cls=clear
alias tmux='tmux -u' # force utf-8
alias lg='lazygit'
alias nv=nvim

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

# Disable Ctrl-S when stdin is open.
if [ -t 0 ]; then
    stty stop undef
fi

#------------------------
# Locale
#------------------------
export LC_ALL=C.UTF-8

PATH=~/tools:$PATH

#------------------------
# Machine specific settings
#------------------------
if [ -e ${HOME}/.additional.sh ]; then
    source ${HOME}/.additional.sh
fi

export PATH="$PATH:/usr/local/go/bin"

function dict() {
    if echo $1 | grep -q '\<[0-9A-Za-z]'; then
        grep ^$1 ~/tools/dict/gene.utf8 -A 1 -wi --color
    else
        grep ^$1 ~/tools/dict/edict.utf8 -wi --color
    fi
}

autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic

if [ -z "$TMUX$ZELLIJ$VIM" ]; then
    tmux
fi

eval "$(starship init zsh)"
