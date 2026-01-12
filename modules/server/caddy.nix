{
  services.caddy = {
    enable = true;
    virtualHosts = {
      "watch.exondation.com" = {
        extraConfig = ''
          reverse_proxy localhost:8096
        '';
      };
    };
  };
}
