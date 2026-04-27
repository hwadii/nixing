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
        position = "right";
        showCapsule = true;
        widgets = {
          left = [
            {
              id = "ControlCenter";
              useDistroLogo = true;
            }
          ];
          center = [
            {
              id = "Workspace";
              labelMode = "none";
            }
          ];
          right = [
            {
              id = "Network";
            }
            {
              id = "Bluetooth";
            }
            {
              formatHorizontal = "HH:mm";
              formatVertical = "HH mm";
              id = "Clock";
              usePrimaryColor = true;
            }
          ];
        };
      };
      appLauncher = {
        enableClipboardHistory = true;
        terminalCommand = "foot";
      };
      wallpaper = {
        enabled = true;
        overviewEnabled = true;
      };
      colorSchemes.predefinedScheme = "Monochrome";
      location = {
        monthBeforeDay = true;
        name = "Paris, France";
      };
    };
  };
}
