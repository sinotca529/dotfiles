{ ... }:

{
  # Hyprland 本体は pacman で入れる (GUI アプリのため)。
  # hyprland.lua と自作ランチャー kiten (tools/kiten) をまとめて配置する。
  xdg.configFile."hypr".source = ./config;
}
