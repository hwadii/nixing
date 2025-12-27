{
  gtk = {
    enable = true;
    font = {
      name = "sans";
    };
    iconTheme = {
      name = "Adwaita";
    };
    theme = {
      name = "Adwaita";
    };
    gtk4.extraConfig = {
      color-scheme = "prefer-dark";
      gtk-application-prefer-dark-theme = 1;
      gtk-cursor-theme-name = "Adwaita";
      gtk-cursor-theme-size = 24;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
      gtk-cursor-theme-name = "Adwaita";
      gtk-cursor-theme-size = 24;
    };
    gtk2.extraConfig = ''
      gtk-application-prefer-dark-theme=1
      gtk-cursor-theme-name="Adwaita"
      gtk-cursor-theme-size=24
    '';
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        gtk-theme = "Adwaita";
        icon-theme = "Adwaita";
        cursor-theme = "Adwaita";
        color-scheme = "prefer-dark";
      };
    };
  };
}
