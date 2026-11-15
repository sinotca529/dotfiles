{ ... }:

{
  programs.fish = {
    enable = true;

    # 対話シェルのときだけ実行。
    interactiveShellInit = ''
      fish_config theme choose tomorrow-night-bright
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
}
