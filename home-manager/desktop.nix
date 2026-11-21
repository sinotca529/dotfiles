{ pkgs, ... }:

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

  # GUI 環境で使う CLI / TUI ツール
  home.packages = with pkgs; [
    bluetuith # Bluetooth 管理 (TUI)
    wev # Wayland の入力イベント表示
    wl-clipboard # wl-copy / wl-paste
  ];
}
