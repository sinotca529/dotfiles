{ ... }:

{
  gtk = {
    enable = true;

    # GTK 3 アプリ (thunar, firefox, waybar など)
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      # 入力欄で Ctrl+A/E/K など Emacs 風のキー操作を使う (GTK 4 には無い機能)
      gtk-key-theme-name = "Emacs";
    };

    # GTK 4 アプリ (pavucontrol など)
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  # libadwaita を使うアプリ (pinta など) は settings.ini ではなくこちらを見る。
  # xdg-desktop-portal-gtk 経由で読まれる。
  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
}
