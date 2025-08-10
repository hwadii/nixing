{ config, pkgs, ... }:

{
  imports = [
    ./gui
    ./tools
  ];

  home.username = "wadii";
  home.homeDirectory = "/home/wadii";
  home.pointerCursor.gtk.enable = true;
  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;
  };

  home.sessionVariables = {
    SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh";
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
  };

  home.packages = with pkgs; [
    emacs-lsp-booster
    fd
    firefox
    git
    grim
    mise
    nixfmt-rfc-style
    nixfmt-tree
    numix-gtk-theme
    pavucontrol
    ripgrep
    slurp
    spotify
    swaybg
    wmenu
  ];

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";
}
