{ config, pkgs, ... }:

{
  wayland.windowManager.labwc = {
    enable = false;
    autostart = [
      "${pkgs.swaybg}/bin/swaybg -i ${config.home.homeDirectory}/dev/nixing/img/focus_intensely.jpg >/dev/null 2>&1 &"
    ];
    rc = { };
    menu = [ ];
  };

  xdg.configFile."labwc" = {
    source = ../../config/labwc;
    recursive = true;
  };
}
