{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 24;
        modules-left = [ "wlr/taskbar" ];
        modules-center = [ "clock" ];
        modules-right = [ "custom/separator" "pulseaudio" "custom/separator" "idle_inhibitor" "custom/separator" "network" "custom/separator" "memory" "custom/separator" "battery" "tray"];
        "wlr/taskbar" = {
          format = "{title}";
          on-click = "minimize-raise";
        };
        "custom/separator" = {
          format = " • ";
          interval = "once";
          tooltip = false;
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
