#!/usr/bin/env bash
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Freedesktop default paths
XDG_DATA_HOME="$HOME/.local/share"
XDG_DATA_DIRS="/usr/local/share:/usr/share"

# .desktop ディレクトリ一覧を返す
get_desktop_dirs() {
  local dirs=("$XDG_DATA_HOME/applications")
  IFS=':' read -ra bases <<< "$XDG_DATA_DIRS"
  for base in "${bases[@]}"; do
    dirs+=("$base/applications")
  done
  printf '%s\n' "${dirs[@]}"
}

# .desktop ファイルをパースして entries 配列に追加
process_desktop_file() {
  local file="$1" section main_name main_exec
  local action_id
  declare -A action_names action_execs

  while IFS= read -r line; do
    case "$line" in
      \[Desktop\ Entry\])
        section="entry"
        ;;
      \[Desktop\ Action\ *\])
        section="action";
        action_id="${line:16:-1}"
        ;;
      \[*\])
        section=""
        ;;
      Name=*)
        if [[ $section == entry ]]; then
          main_name="${line#Name=}"
        elif [[ $section == action && -n $action_id ]]; then
          action_names[$action_id]="${line#Name=}"
        fi
        ;;
      Exec=*)
        local exe="${line#Exec=}"
        exe="${exe%% %*}"
        if [[ $section == entry ]]; then
          main_exec="$exe"
        elif [[ $section == action && -n $action_id ]]; then
          action_execs[$action_id]="$exe"
        fi
        ;;
    esac
  done < "$file"

  if [[ -n $main_name && -n $main_exec ]]; then
    entries+=("$main_name:${main_exec}")
  fi
  for id in "${!action_names[@]}"; do
    entries+=("$main_name — ${action_names[$id]}:${action_execs[$id]}")
  done
}

# 全エントリを entries に詰める
collect_entries() {
  entries=()
  for dir in $(get_desktop_dirs); do
    [[ -d $dir ]] || continue
    while IFS= read -r file; do
      process_desktop_file "$file"
    done < <(find "$dir" -type f,l -name '*.desktop')
  done
}

# ランチャー本体
run_launcher() {
  local TMP_LIST result query selection

  # いちどキャッシュを作る
  TMP_LIST=$(mktemp)
  collect_entries
  printf '%s\n' "${entries[@]}" > "$TMP_LIST"

  result=$(
    fzf \
      --print-query \
      --bind "change:reload(bash \"$SCRIPT_DIR/get-candidates.sh\" {q} \"$TMP_LIST\")" \
      --height=15 --layout=reverse < /dev/null
  )

  query=$(head -n1 <<< "$result")
  selection=$(tail -n1 <<< "$result")

  if [[ $query == =* ]]; then
    num="${selection%% *}"
    echo $num | wl-copy
    echo $num
  elif [[ -n $selection ]]; then
    cmd="${selection#*:}"
    setsid -f $cmd
  fi

  rm "$TMP_LIST"
}

main() {
  run_launcher
}

main
