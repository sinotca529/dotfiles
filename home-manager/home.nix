{ pkgs, ... }:

{
  home.username = "takumi";
  home.homeDirectory = "/home/takumi";

  # 規定値の基準とする Home Manager のバージョン。
  # 基本的に変更しない。
  home.stateVersion = "26.05";

  # NixOS 以外の Linux で使うための調整。
  targets.genericLinux.enable = true;

  # GPU 有効化
  targets.genericLinux.gpu.enable = true;

  # home-manager コマンド自体も Home Manager で管理する。
  programs.home-manager.enable = true;

  imports = [
    ./gh.nix
    ./git.nix
    ./lazygit.nix
    ./starship
    ./tmux
    ./yazi.nix
  ];

  home.packages = with pkgs; [
    bat
    binsider
    bottom
    cloc
    eza
    fd
    fzf
    mdbook
    ripgrep
    ripgrep-all
    tokei
    tree-sitter
    typst
  ];
}
