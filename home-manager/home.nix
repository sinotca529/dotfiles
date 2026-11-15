{ pkgs, ... }:

{
  home.username = "takumi";
  home.homeDirectory = "/home/takumi";

  # 規定値の基準とする Home Manager のバージョン。
  # 基本的に変更しない。
  home.stateVersion = "26.05";

  # NixOS 以外の Linux で使うための調整。
  targets.genericLinux.enable = true;

  home.packages = with pkgs; [
    bat
  ];

  # home-manager コマンド自体も Home Manager で管理する。
  programs.home-manager.enable = true;
}
