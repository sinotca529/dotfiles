{ ... }:

{
  # waybar 本体は pacman で入れる (GUI アプリのため)。
  xdg.configFile."waybar/config".source = ./config;
  xdg.configFile."waybar/style.css".source = ./style.css;
}
