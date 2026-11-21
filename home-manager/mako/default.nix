{ ... }:

{
  # mako 本体は pacman で入れる (GUI アプリのため)。
  xdg.configFile."mako/config".source = ./config;
}
