#------------------------
# prompt
#------------------------
# %M ホスト名
# %m ホスト名
# %d カレントディレクトリ (フルパス)
# %~ カレントディレクトリ (フルパス2)
# %C カレントディレクトリ (相対パス)
# %c カレントディレクトリ (相対パス)
# %n ユーザ名
# %# ユーザ種別
# %? 直前コマンドの終了ステータス
# %D 日付(yy-mm-dd)
# %W 日付(yy/mm/dd)
# %* 時間(hh:flag_mm:ss)
# %T 時間(hh:mm)
# %t 時間(hh:mm(am/pm))
PROMPT='%F{#00ff00}%n@%m%f:%~
$ '

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


#------------------------
# vcs info
#------------------------
# autoload -Uz vcs_info
# setopt prompt_subst
# zstyle ':vcs_info:git:*' check-for-changes true
# zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
# zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
# zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
# zstyle ':vcs_info:*' actionformats '[%b|%a]'
# precmd () { vcs_info }

# 補完を有効化
autoload -U compinit && compinit

# ビープ音オフ
setopt no_beep

# エディタをvimに
export EDITOR=vim


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
    plugman_unset
else
    echo "WARN : Plugin manager does not exist."
fi
unset PLUGMAN


#------------------------
# Alias
#------------------------
alias cls=clear

#------------------------
# OS Specific
#------------------------
# WSL
#if [[ "$(uname -r)" == *microsoft* ]]; then
#    export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
#fi

#------------------------
# Vim
#------------------------
PLUGVIM="$HOME/dotfiles/vim/.vim/autoload/plug.vim"
if [ ! -e $PLUGVIM ]; then
    curl -fLo $PLUGVIM --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

#------------------------
# Rust
#------------------------
source ~/.cargo/env

