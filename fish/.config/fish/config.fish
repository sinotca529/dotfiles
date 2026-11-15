if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_title
  # echo fish
end

abbr -a nv nvim
abbr -a mv mv -i
abbr -a xo xdg-open
abbr -a tmux tmux -u
abbr -a lg lazygit
abbr -a gc git commit
abbr -a v vim
# abbr -a ls ls --color=auto
# abbr -a grep grep --color=auto
# abbr -a fgrep fgrep --color=auto
# abbr -a egrep egrep --color=auto

alias conf='~/dotfiles/zsh/.zsh/conf.sh'

set fish_greeting
set -xa LS_COLORS 'di=0;36:ow=0;36'
set -xg LC_ALL ja_JP.UTF-8
set -xg LANG ja_JP.UTF-8

# WSL2 + systemd で /run/user/$UID が用意されず XDG_RUNTIME_DIR が壊れることがあるための代替
# (serverstart() に依存する fzf-lua 等が失敗する: https://github.com/ibhagwan/fzf-lua/issues/1243)
if not test -w "/run/user/"(id -u)
    if not test -d "$HOME/.xdg_runtime"
        mkdir -m 0700 "$HOME/.xdg_runtime"
    end
    set -gx XDG_RUNTIME_DIR "$HOME/.xdg_runtime"
end

# Nix の PATH などを設定する
if test -e /etc/profile.d/nix-daemon.fish
    source /etc/profile.d/nix-daemon.fish
end

fish_add_path ~/tools
fish_add_path ~/go/bin
fish_add_path /usr/local/go/bin
fish_add_path ~/tools/lazydocker
fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/tools/bin
fish_add_path /mnt/c/Program\ Files/VOICEPEAK/

starship init fish | source

function activate_tmux
  if test -z "$TMUX$ZELLIJ$VIM"
    if test -n "$(tmux list-sessions 2>/dev/null | grep -v attached)"
      tmux -u a
    else
      tmux -u
    end
  end
end

activate_tmux
