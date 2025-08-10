{ config, pkgs, ... }:

{
  wayland.windowManager.labwc = {
    enable = true;
    autostart = [
      "${pkgs.swaybg}/bin/swaybg -i ${config.home.homeDirectory}/dev/nixing/img/focus_intensely.jpg >/dev/null 2>&1 &"
    ];
    rc = {
      theme = {
        name = "Numix";
        font = {
          "@name" = "sans";
          "@size" = "10";
        };
      };
      keyboard = {
        repeatRate = 30;
        repeatDelay = 400;
        default = true;
        keybind = [
          {
            "@key" = "W-Return";
            action = {
              "@name" = "Execute";
              "@command" = "foot";
            };
          }
          {
            "@key" = "W-d";
            action = {
              "@name" = "Execute";
              "@command" = "wmenu-run";
            };
          }
        ];
      };
    };
    menu = [
      {
        menuId = "client-menu";
        label = "Client Menu";
        items = [
          {
            label = "Minimize";
            action = {
              name = "Iconify";
            };
          }
          {
            label = "Maximize";
            action = {
              name = "ToggleMaximize";
            };
          }
          {
            label = "Fullscreen";
            action = {
              name = "ToggleFullscreen";
            };
          }
          {
            label = "Always on Top";
            action = {
              name = "ToggleAlwaysOnTop";
            };
          }
          {
            label = "Workspace";
            menuId = "workspace";
            items = [
              {
                label = "Move Left";
                action = {
                  name = "SendToDesktop";
                  to = "left";
                };
              }
              {
                label = "Move Right";
                action = {
                  name = "SendToDesktop";
                  to = "right";
                };
              }
            ];
          }
          {
            label = "Decorations";
            action = {
              name = "ToggleDecorations";
            };
          }
          {
            label = "Close";
            action = {
              name = "Close";
            };
          }
        ];
      }
      {
        menuId = "root-menu";
        label = "";
        items = [
          {
            label = "Web browser";
            action = {
              name = "Execute";
              command = "firefox";
            };
          }
          {
            label = "Terminal";
            action = {
              name = "Execute";
              command = "wezterm";
            };
          }
          {
            label = "Reconfigure";
            action = {
              name = "Reconfigure";
            };
          }
          {
            label = "Lock";
            action = {
              name = "Execute";
              command = "swaylock --daemonize";
            };
          }
          {
            label = "Suspend";
            action = {
              name = "Execute";
              command = "systemctl suspend";
            };
          }
          {
            label = "Exit";
            action = {
              name = "Exit";
            };
          }
          {
            label = "Poweroff";
            action = {
              name = "Execute";
              command = "systemctl -i poweroff";
            };
          }
        ];
      }
    ];
  };
}
