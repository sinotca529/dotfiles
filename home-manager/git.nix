{ ... }:

{
  programs.git = {
    enable = true;

    # git 本体は pacman 版を利用 (paru が依存しているため)
    package = null;

    settings = {
      user = {
        name = "Takumi Watanabe";
        email = "52117877+sinotca529@users.noreply.github.com";
      };
      init.defaultBranch = "main";
    };

    ignores = [
      "**/.claude/settings.local.json"
    ];
  };
}
