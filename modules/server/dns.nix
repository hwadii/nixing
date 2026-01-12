{ pkgs, ... }:

let
  lanIp = "192.168.1.150";
  tailscaleIp = "100.68.65.84";
in
{
  networking.nameservers = [ "127.0.0.1" ];

  networking.firewall = {
    interfaces.eno1.allowedUDPPorts = [ 53 ];
    interfaces.eno1.allowedTCPPorts = [ 53 ];

    interfaces.tailscale0.allowedUDPPorts = [ 53 ];
    interfaces.tailscale0.allowedTCPPorts = [ 53 ];
  };

  services.resolved = {
    enable = true;
    dnssec = "false";
    extraConfig = ''
      DNSStubListener=no
    '';
  };

  services.dnsmasq = {
    enable = false;
    settings = {
      listen-address = [ "127.0.0.1" lanIp tailscaleIp ];
      bind-interfaces = true;
      domain = "exondation.com";
      address = [
        "/exondation.com/${lanIp}"
      ];
      dhcp-range = "192.168.1.50,192.168.1.200,12h";
      dhcp-authoritative = true;
      expand-hosts = true;
      cache-size = 1000;
      no-resolv = false;
    };
  };

  environment.etc."dnsmasq-lan.conf".text = ''
    interface=eno1
    bind-interfaces

    domain=exondation.com

    address=/exondation.com/${tailscaleIp}
  '';

  environment.etc."dnsmasq-ts.conf".text = ''
    interface=tailscale0
    bind-interfaces

    domain=exondation.com

    address=/exondation.com/${tailscaleIp}
  '';

  systemd.services.dnsmasq-lan = {
    description = "dnsmasq (LAN)";
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.dnsmasq}/bin/dnsmasq --keep-in-foreground --conf-file=/etc/dnsmasq-lan.conf";
      Restart = "always";
    };
  };

  systemd.services.dnsmasq-ts = {
    description = "dnsmasq (Tailscale)";
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.dnsmasq}/bin/dnsmasq --keep-in-foreground --conf-file=/etc/dnsmasq-ts.conf";
      Restart = "always";
    };
  };
}
