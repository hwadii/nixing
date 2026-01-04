{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.qbittorrent-cli ];

  services.qbittorrent = {
    enable = true;
    webuiPort = 8097;
    openFirewall = true;
    user = "wadii";
    serverConfig = {
      LegalNotice.Enabled = true;
      Preferences = {
        WebUI = {
          Username = "wadii";
          Password_PBKDF2 = "y8F1670S5YAXxA0LxNkZ5w==:d5lipDOMPEPsFdMotOTVimEioaxYs5XJTtcBcYmFItmPID29Cs6dyJcly976vSlu16KAj+2b+P6MVoZd7Tbhtg==";
        };
        General.Locale = "en";
      };
    };
  };
}
