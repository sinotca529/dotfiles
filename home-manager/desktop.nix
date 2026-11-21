{ ... }:

# GUI 環境 (Hyprland) を使うマシンだけの設定。home.nix に重ねて使う。
# GUI アプリ本体は pacman で入れ、ここでは設定ファイルだけを管理する。
# (Nix の GUI アプリは NixOS 以外だと OpenGL ドライバを見つけられないため)
{
  imports = [
    ./foot
    ./gtk.nix
    ./hypr
    ./mako
    ./waybar
    ./zathura.nix
  ];
}
