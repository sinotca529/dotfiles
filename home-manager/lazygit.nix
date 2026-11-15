{ ... }:

{
  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        splitDiff = "always";
        showIcons = true;
        nerdFontsVersion = "3";
      };
      git = {
        log.showGraph = "always";
        merging.args = "--no-ff";
      };
    };
  };
}
