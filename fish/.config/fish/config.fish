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
# abbr -a ls ls --color=auto
# abbr -a grep grep --color=auto
# abbr -a fgrep fgrep --color=auto
# abbr -a egrep egrep --color=auto

alias conf='~/dotfiles/zsh/.zsh/conf.sh'

set fish_greeting
set -xa LS_COLORS 'di=0;36:ow=0;36'
set -xg LC_ALL en_US.UTF-8
set -xg LANG en_US.UTF-8

fish_add_path ~/tools
fish_add_path ~/go/bin
fish_add_path /usr/local/go/bin
fish_add_path ~/tools/lazydocker
fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin

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
