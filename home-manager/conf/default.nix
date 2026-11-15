{ pkgs, ... }:

{
  home.packages = [
    (pkgs.writeShellApplication {
      name = "conf";
      text = builtins.readFile ./conf.sh;
    })
  ];
}
