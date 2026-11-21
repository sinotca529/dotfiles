{ config, pkgs, ... }:

{
  home.packages = [ pkgs.neovim ];

  # git commit などで起動するエディタ
  home.sessionVariables.EDITOR = "nvim";

  # lazy.nvim が lazy-lock.json を書き換えるので、store にコピーせず dotfiles を直接リンクする。
  # 編集はすぐ反映されるが、ロールバックしても設定は戻らない(戻すときは git で)。
  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/home-manager/nvim/config";
}
