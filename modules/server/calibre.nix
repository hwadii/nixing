{
  services.calibre-web = {
    enable = true;
    user = "wadii";
    options = {
      enableBookUploading = true;
      calibreLibrary = "/mnt/a/books";
    };
    openFirewall = true;
    listen = {
      ip = "0.0.0.0";
      port = 8083;
    };
  };
}
