{ ... }:

{
  # makepkg (yay で AUR をビルドするときにも使われる) のユーザー設定。
  # /etc/makepkg.conf の後に bash として読み込まれ、値を上書きする。
  xdg.configFile."pacman/makepkg.conf".text = ''
    # -debug パッケージを作らない (yay がそれもインストールしてしまうため)。
    # debug 以外の OPTIONS はシステムの既定に従う。
    OPTIONS=("''${OPTIONS[@]/#debug/!debug}")

    # CPU のコア数だけ並列でビルドする
    MAKEFLAGS="-j$(nproc)"
  '';
}
