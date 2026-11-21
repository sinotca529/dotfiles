{ pkgs, ... }:

{
  home.username = "takumi";
  home.homeDirectory = "/home/takumi";

  # 規定値の基準とする Home Manager のバージョン。
  # 基本的に変更しない。
  home.stateVersion = "26.05";

  # NixOS 以外の Linux で使うための調整は使わない。
  # Nix の環境設定は Arch の nix パッケージの /etc/profile.d/nix-daemon.sh に任せる。
  # genericLinux はシングルユーザー版の nix.sh も読み込むため、PATH が重複する。
  # https://github.com/nix-community/home-manager/issues/2012
  # https://github.com/nix-community/home-manager/issues/8076
  targets.genericLinux.enable = false;

  # home-manager コマンド自体も Home Manager で管理する。
  programs.home-manager.enable = true;

  # 週に 1 回、30 日より古い世代を消して /nix/store のゴミを回収する。
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 30d";
  };

  imports = [
    ./bash.nix
    ./clangd
    ./conf
    ./fish
    ./foot
    ./gh.nix
    ./git.nix
    ./gtk.nix
    ./lazygit.nix
    ./mako
    ./nvim
    ./pict
    ./shell.nix
    ./starship
    ./tmux
    ./yazi.nix
    ./zathura.nix
  ];

  home.packages = with pkgs; [
    bat
    bc
    binsider
    bottom
    cloc
    eza
    fd
    fzf
    libtree
    mdbook
    nixfmt
    prettier
    ripgrep
    ripgrep-all
    stow
    tokei
    tree-sitter
    typst
    unzip
    wget
    xdg-utils
    zip
  ];
}
