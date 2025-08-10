{ config, pkgs, ... }:

{
  home.packages = [ pkgs.git ];

  xdg.configFile."git" = {
    source = ../../config/git;
    recursive = true;
  };
}
