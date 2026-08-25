{ config, pkgs, ... }:

{
  networking.hostName = "silverwing";

  environment.systemPackages = with pkgs; [
    neovim
    wget
    curl
  ];

  programs.fish = {
    enable = true;
    shellInit = ''
      fish_add_path -amP /opt/homebrew/bin
    '';
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  homebrew = {
    enable = true;
    taps = [
      "d12frosted/emacs-plus"
    ];
    casks = [
      "cursor"
      "emacs-plus-app"
      "ghostty"
      "thunderbird@esr"
    ];
    brews = [
      "colima"
    ];
    onActivation.cleanup = "zap";
  };

  fonts.packages = with pkgs; [
    jetbrains-mono
    liberation_ttf
    lexend
  ];

  users.users.wadii = {
    name = "wadii";
    home = "/Users/wadii";
  };

  environment.shells = [ pkgs.fish ];

  environment.enableAllTerminfo = true;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "aarch64-darwin";

  system = {
    stateVersion = 5;

    primaryUser = "wadii";

    # Menu and system
    defaults.NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      AppleMeasurementUnits = "Centimeters";
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      AppleShowScrollBars = "Automatic";
    };

    # Dock stuff
    defaults.dock.autohide = true;
  };

  time.timeZone = "Europe/Paris";
}
