# dotfiles 内のツールの設定を nvim で開く
#
#   conf          dotfiles 全体を開く
#   conf <名前>   そのツールの設定を開く。次の順に探す
#                   1. home-manager/<名前>/      (設定ファイルを伴うモジュール)
#                   2. home-manager/<名前>.nix   (Nix だけで完結するモジュール)

dotfiles="$HOME/dotfiles"

# ディレクトリを開く。中身が 1 つだけのディレクトリは自動でたどる
open_dir() {
  local dir=$1
  shopt -s nullglob dotglob
  while true; do
    local entries=("$dir"/*)
    if ((${#entries[@]} != 1)); then
      exec nvim -c "cd $dir" "$dir"
    elif [[ -d ${entries[0]} ]]; then
      dir=${entries[0]}
    else
      exec nvim -c "cd $dir" "${entries[0]}"
    fi
  done
}

if (($# == 0)); then
  exec nvim -c "cd $dotfiles" "$dotfiles"
fi

name=$1

if [[ -d $dotfiles/home-manager/$name ]]; then
  open_dir "$dotfiles/home-manager/$name"
elif [[ -f $dotfiles/home-manager/$name.nix ]]; then
  exec nvim -c "cd $dotfiles/home-manager" "$dotfiles/home-manager/$name.nix"
else
  echo "Configuration for '$name' does not exist." >&2
  exit 1
fi
