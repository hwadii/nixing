let
  lanIp = "192.168.1.150";
in
{
  networking.nameservers = [ "127.0.0.1" ];
  services.resolved = {
    enable = true;
    dnssec = "false";
    extraConfig = ''
      DNSStubListener=no
    '';
  };

  services.dnsmasq = {
    enable = true;
    settings = {
      listen-address = [ "127.0.0.1" lanIp ];
      bind-interfaces = true;
      domain = "lan";
      local = "/lan/";
      address = [ "/balerion.lan/${lanIp}" ];
      dhcp-range = "192.168.1.50,192.168.1.200,12h";
      dhcp-authoritative = true;
      expand-hosts = true;
      cache-size = 1000;
      no-resolv = false;
    };
  };
}
