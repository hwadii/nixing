{ config, ... }:

{
  programs.swaylock = {
    enable = true;
    settings = {
      daemonize = true;
      ignore-empty-password = true;
      indicator-idle-visible = false;
      show-failed-attempts = true;
      indicator-radius = 80;
      indicator-thickness = 20;
      inside-color = "ffffff00";
      ring-color = "1d99f388";
      line-uses-ring  = true;
      separator-color = "1d99f322";
      text-color = "ffffff";
      text-clear-color = "ffffff";
      text-caps-lock-color = "ffffff";
      image = "${config.home.homeDirectory}/dev/nixing/img/focus_intensely.jpg";
    };
  };
}
