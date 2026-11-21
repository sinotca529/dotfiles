#!/usr/bin/env bash
# Hyprland のショートカット早見表。SUPER + / か waybar の 󰌌 で開く。
#
# 一覧は `hyprctl binds -j` から作るので、ここにキーの一覧は持たない。
# 説明は hyprland.lua の bind に付けた desc をそのまま使う (desc の無い bind は出ない)。
# 隣り合う bind で desc と修飾キーが同じものは 1 行にまとめる (例: SUPER + [1-0])。
set -euo pipefail

list_binds() {
  hyprctl binds -j | jq -r '
    def mods: . as $m
      | [[64, "SUPER"], [4, "CTRL"], [8, "ALT"], [1, "SHIFT"]]
      | map(select(($m / .[0] | floor) % 2 == 1) | .[1]);
    def keyname:
      {"minus": "-", "equal": "=", "slash": "/", "SPACE": "Space", "TAB": "Tab",
       "mouse:272": "LMB-drag", "mouse:273": "RMB-drag"}[.]
      // (if startswith("XF86") then .[4:] else . end);
    def keys: if length > 2 then "[\(first)-\(last)]" else join("/") end;
    def pad($n): . + (" " * ([$n - length, 1] | max));

    [ .[] | select(.has_description)
      | {sub: .submap, mods: (.modmask | mods), key: (.key | keyname), desc: .description} ]
    | reduce .[] as $b ([];
        if length > 0 and (.[-1] | .desc == $b.desc and .mods == $b.mods and .sub == $b.sub)
        then .[-1].keys += [$b.key]
        else . + [$b + {keys: [$b.key]}] end)
    | .[]
    | ((.mods + [.keys | keys]) | join(" + ") | pad(26))
      + (if .sub != "" then "(\(.sub) 中) " else "" end)
      + .desc
  '
}

# Enter でも Esc でも閉じるだけ (見るためのもの)
list_binds | fzf \
  --no-sort --layout=reverse --info=hidden \
  --prompt='絞り込み> ' \
  --header='キー or 説明で検索 / Esc で閉じる' \
  --color='bg+:#3b4252,hl:#88c0d0,hl+:#88c0d0,pointer:#88c0d0,prompt:#81a1c1,header:#4c566a' \
  >/dev/null || true
