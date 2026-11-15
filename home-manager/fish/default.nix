{ ... }:

{
  programs.fish = {
    enable = true;

    # 対話シェルのときだけ tmux を実行。
    interactiveShellInit = ''
      activate_tmux
    '';

    shellAbbrs = {
      gc = "git commit";
      lg = "lazygit";
      mv = "mv -i";
      nv = "nvim";
      tmux = "tmux -u";
      v = "vim";
      xo = "xdg-open";
    };

    functions = {
      fish_greeting = "";
      fish_title = "";
      activate_tmux = ''
        if test -z "$TMUX$ZELLIJ$VIM"
          if test -n "$(tmux list-sessions 2>/dev/null | grep -v attached)"
            tmux -u a
          else
            tmux -u
          end
        end
      '';
    };
  };

  # fish 4.3 の移行で作られた配色の設定
  xdg.configFile."fish/conf.d/fish_frozen_theme.fish".source = ./fish_frozen_theme.fish;
}
