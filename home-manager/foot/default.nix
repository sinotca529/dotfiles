{ ... }:

{
  # foot 本体は pacman で入れる。
  # Nix の GUI アプリは NixOS 以外だと OpenGL ドライバを見つけられないため。
  xdg.configFile."foot/foot.ini".source = ./foot.ini;
}
