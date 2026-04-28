{ pkgs, config, ... }:

{
  home.file.".cache/noctalia/wallpapers.json" = {
    text = builtins.toJSON {
      defaultWallpaper = "/home/wadii/dev/nixing/img/berries.png";
    };
  };

  programs.noctalia-shell = {
    enable = true;
    settings = {
      bar = {
        density = "compact";
        position = "top";
        showCapsule = true;
        widgets = {
          left = [
            {
              id = "ActiveWindow";
              showIcon = true;
              maxWidth = 512;
            }
            {
              id = "MediaMini";
            }
          ];
          center = [
            {
              id = "Workspace";
              labelMode = "none";
              hideUnoccupied = false;
            }
          ];
          right = [
            {
              id = "Tray";
            }
            {
              id = "Battery";
            }
            {
              id = "Volume";
            }
            {
              id = "Clock";
              formatHorizontal = "HH:mm ddd, MMM dd";
            }
            {
              id = "ControlCenter";
            }
          ];
        };
      };
      dock = {
        enabled = false;
      };
      appLauncher = {
        enableClipboardHistory = true;
        terminalCommand = "foot";
      };
      wallpaper = {
        enabled = true;
        overviewEnabled = true;
      };
      # colorSchemes.predefinedScheme = "Monochrome";
      location = {
        monthBeforeDay = true;
        name = "Paris, France";
      };
    };
  };
}
