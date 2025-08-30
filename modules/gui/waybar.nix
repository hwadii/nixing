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
          border: none;
          border-radius: 0;
          font-family: sans-serif;
          font-size: 13px;
          min-height: 0;
      }

      window#waybar {
          background: rgba(43, 48, 59, 1);
          border-bottom: 3px solid rgba(100, 114, 125, 0.5);
          color: white;
      }

      tooltip {
        background: rgba(43, 48, 59, 0.5);
        border: 1px solid rgba(100, 114, 125, 0.5);
      }
      tooltip label {
        color: white;
      }

      #workspaces button {
          padding: 0 5px;
          background: transparent;
          color: white;
          border-bottom: 3px solid transparent;
      }

      #workspaces button.focused {
          background: #64727D;
          border-bottom: 3px solid white;
      }

      #mode, #clock, #battery {
          padding: 0 10px;
      }

      #mode {
          background: #64727D;
          border-bottom: 3px solid white;
      }

      #battery {
          background-color: #ffffff;
          color: black;
      }

      #battery.charging {
          color: white;
          background-color: #26A65B;
      }

      @keyframes blink {
          to {
              background-color: #ffffff;
              color: black;
          }
      }

      #battery.warning:not(.charging) {
          background: #f53c3c;
          color: white;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: steps(12);
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }
    '';
  };
}
