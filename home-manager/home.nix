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

  # 週に 1 回、30 日より古い世代を消して /nix/store のゴミを回収する。
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 30d";
  };

  imports = [
    ./bash.nix
    ./conf
    ./fish
    ./gh.nix
    ./git.nix
    ./lazygit.nix
    ./nvim
    ./shell.nix
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
