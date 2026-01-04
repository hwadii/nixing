{ pkgs, ... }:

{
  networking.firewall.allowedTCPPorts = [ 8384 ];

  services.syncthing = {
    enable = true;
    user = "wadii";
    openDefaultPorts = true;
    guiAddress = "0.0.0.0:8384";
    overrideFolders = false;
    overrideDevices = false;
  };
}
