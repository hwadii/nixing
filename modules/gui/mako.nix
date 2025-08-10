{
  services.mako = {
    enable = true;
    settings = {
      layer = "overlay";
      background-color = "#222222";
      border-color = "#555555";
      default-timeout = 8000;
      group-by = "app-name";
      max-icon-size = 32;
      actions = true;
      hidden = {
        format = "(and %h more)";
        text-color="#777777";
      };
      "urgency=high" = {
        background-color = "#c00000";
        border-color = "#ff0000";
        ignore-timeout = 1;
      };
      "mode=dnd" = {
        invisible = 1;
      };
    };
  };
}
