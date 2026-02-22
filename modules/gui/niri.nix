{ pkgs, ... }:

{
  home.packages = [ pkgs.xwayland-satellite ];

  xdg.configFile."niri" = {
    source = ../../config/niri;
    recursive = true;
  };
}
