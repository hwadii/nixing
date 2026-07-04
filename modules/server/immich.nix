{
  services.immich = {
    enable = true;
    port = 2283;
    host = "0.0.0.0";
    openFirewall = true;
    environment = {
      IMMICH_LOG_LEVEL = "warn";
    };
    mediaLocation = "/mnt/a/photos";
  };

  services.redis.servers.immich.logLevel = "warning";
}
