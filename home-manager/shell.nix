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
    "$HOME/tools"
    "$HOME/tools/bin"
    "$HOME/go/bin"
    "$HOME/.local/bin"
    "$HOME/.cargo/bin"
    "/mnt/c/Program Files/VOICEPEAK"
  ];

  # どのシェルでも共通のエイリアス
  home.shellAliases = {
    conf = "~/dotfiles/zsh/.zsh/conf.sh";
  };
}
