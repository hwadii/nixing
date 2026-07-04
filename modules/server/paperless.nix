{ pkgs, ... }:

{
  networking.firewall.allowedTCPPorts = [ 28981 ];

  services.paperless = {
    enable = true;
    consumptionDirIsPublic = true;
    address = "0.0.0.0";
    port = 28981;
    user = "wadii";
    dataDir = "/mnt/a/papers";
    settings = {
      PAPERLESS_CONSUMER_IGNORE_PATTERN = [
        ".DS_STORE/*"
        "desktop.ini"
      ];
      PAPERLESS_OCR_LANGUAGE = "fra";
      PAPERLESS_OCR_USER_ARGS = {
        optimize = 1;
        pdfa_image_compression = "lossless";
      };
      PAPERLESS_URL = "https://papers.h.exondation.com";
    };
  };
}
