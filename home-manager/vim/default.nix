{ config, ... }:

{
  # vim 本体は pacman で入れる(sudo vim で root からも使えるように)。
  # プラグインは vim-plug で管理する(Windows でも同じ vimrc を使うため)。

  # 移植作業で頻繁に編集するので、store にコピーせず dotfiles を直接リンクする。
  home.file.".vimrc".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/home-manager/vim/vimrc";

  # vimrc-tmux は `vim -Nu <パス>` で直接指定して使うので、リンクしない。
}
