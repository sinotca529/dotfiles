{ config, lib, ... }:

let
  fish = lib.getExe config.programs.fish.package;
in
{
  # POSIX シェルをログインシェルとする目的で bash を導入。
  # ただし普段は fish を利用するため、対話的に起動された場合は fish に切り替える。
  programs.bash = {
    enable = true;

    # starship などの bash 連携より先に切り替えて、無駄な初期化を省く
    initExtra = lib.mkBefore ''
      # 親が fish でなく、bash -c でもなければ fish に切り替える。
      # fish を実行できなければ何もしない。
      if [[ $(ps -o comm= -p "$PPID") != fish && -z $BASH_EXECUTION_STRING && -x ${fish} ]]; then
        shopt -q login_shell && LOGIN_OPTION=--login || LOGIN_OPTION=
        exec ${fish} $LOGIN_OPTION
      fi
    '';
  };
}
