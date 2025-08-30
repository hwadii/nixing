{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 24;
        modules-left = [ "niri/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [
          "custom/separator"
          "pulseaudio"
          "custom/separator"
          "idle_inhibitor"
          "custom/separator"
          "network"
          "custom/separator"
          "memory"
          "custom/separator"
          "battery"
          "tray"
        ];
        "custom/separator" = {
          format = " • ";
          interval = "once";
          tooltip = false;
        };
        clock = {
          interval = 60;
          tooltip = true;
          format = "{:%H:%M %Y-%m-%d}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
        };
      };
    };
    style = ''
      * {
        background-color: rgba(43, 48, 59, 1);
        color: #fff;
      }
    '';
  };
}
