{ ... }:

{
  # zathura 本体は pacman で入れる (GUI アプリのため)。
  # 選択したテキストを PRIMARY ではなく CLIPBOARD にコピーする。
  xdg.configFile."zathura/zathurarc".text = ''
    set selection-clipboard clipboard
  '';
}
