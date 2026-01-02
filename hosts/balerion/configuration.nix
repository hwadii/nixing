# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ modulesPath, lib, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./disk-config.nix
  ];

  nix.settings.trusted-users = [ "wadii" "root" ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "balerion"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Use systemd for networking
  services.resolved.enable = true;
  networking.useDHCP = false;
  systemd.network.enable = true;
  systemd.network.networks."10-e" = {
    matchConfig.Name = "e*";
    networkConfig = {
      IPv6AcceptRA = true;
      DHCP = "yes";
    };
  };

  users.mutableUsers = false;
  security.sudo.wheelNeedsPassword = false;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.wadii = {
    isNormalUser = true;
    description = "Wadii Hajji";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGdNFG58u5AIrMVNpUE3k7bSul6ZdF2zjhj2WNPOy/qR wadii@caraxes"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAdoh7/O4RkU5sY53Bqko7RzQXanA6Ma0/F6AdnnDSJY wadii@moondancer"
    ];
    hashedPassword = "$6$I4muGA8GIitwrD1N$fJiRKsHwifQoQ9W8L84kNW7xW1nfP1Lt0HbGrlQJGRsFdPI19kn0azlITxL6hOVU1nz/chMhEnpVFiHT4Ogwm.";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    git
    neovim
    wget
    curl
  ];

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
    settings.AllowAgentForwarding = true;
  };

  programs.ssh.startAgent = false;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
