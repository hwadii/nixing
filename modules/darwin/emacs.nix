{ config, pkgs, ... }:

{
  xdg.configFile."emacs" = {
    source = ../../config/emacs;
    recursive = true;
  };
}
