{ config, pkgs, ... }:

{
  services.caddy = {
    enable = true;
    package = pkgs.caddy.withPlugins {
      plugins = [ "github.com/caddy-dns/porkbun@v0.3.1" ];
      hash = "sha256-GKtPd73R/7ggu3fBFilkhyKi45lkAAQFsftwg5pmWW4=";
    };
    virtualHosts."*.h.exondation.com".extraConfig = ''
      tls {
        dns porkbun {
          api_key {env.PORKBUN_API_KEY}
          api_secret_key {env.PORKBUN_API_SECRET_KEY}
        }
      }
      @watch host watch.h.exondation.com
      handle @watch {
        reverse_proxy 127.0.0.1:8096
      }

      @kobo host kobo.h.exondation.com
      handle @kobo {
        reverse_proxy 127.0.0.1:8083
      }

      @sync host sync.h.exondation.com
      handle @sync {
        reverse_proxy 127.0.0.1:8384
      }
      @torrent host torrent.h.exondation.com
      handle @torrent {
        reverse_proxy 127.0.0.1:8097
      }
    '';
  };

  systemd.services.caddy.serviceConfig.EnvironmentFile = "/var/lib/secrets/porkbun.env";
}
