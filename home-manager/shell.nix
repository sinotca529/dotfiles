{ ... }:

{
  # どのシェルでも共通の環境変数
  home.sessionVariables = {
    LANG = "ja_JP.UTF-8";
    LC_ALL = "ja_JP.UTF-8";
    LS_COLORS = "di=0;36:ow=0;36";
  };

  # PATH に追加するディレクトリ
  home.sessionPath = [
    "$HOME/go/bin"
    "$HOME/.local/bin"
    "$HOME/.cargo/bin"
  ];
}
