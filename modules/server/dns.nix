{ pkgs, ... }:

let
  tailscaleIp = "100.68.65.84";
in
{
  networking.nameservers = [ "1.1.1.1" "9.9.9.9" ];

  networking.firewall = {
    interfaces.eno1.allowedUDPPorts = [ 53 ];
    interfaces.eno1.allowedTCPPorts = [ 53 80 443 ];

    interfaces.tailscale0.allowedUDPPorts = [ 53 ];
    interfaces.tailscale0.allowedTCPPorts = [ 53 ];
  };

  services.resolved = {
    enable = false;
  };

  services.dnsmasq = {
    enable = true;
    settings = {
      server = [ "1.1.1.1" "9.9.9.9" ];
      interface = [ "tailscale0" "lo" ];
      bind-interfaces = true;
      address = [ "/h.exondation.com/${tailscaleIp}" ];
      domain-needed = true;
      bogus-priv = true;
      no-resolv = true;
    };
  };

  systemd.services.dnsmasq = {
    after = [ "tailscaled.service" "sys-subsystem-net-devices-tailscale0.device" ];
    wants = [ "sys-subsystem-net-devices-tailscale0.device" ];
  };
}
