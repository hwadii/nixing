{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.calibre ];

  nixpkgs.overlays = [
    (final: prev: {
      calibre-web = prev.calibre-web.overridePythonAttrs (old: {
        postInstall = (old.postInstall or "") + ''
          # no-op: suppress version check
        '';
        dontCheckRuntimeDeps = true;
      });
    })
  ];

  services.calibre-web = {
    enable = true;
    user = "wadii";
    options = {
      enableBookUploading = true;
      enableKepubify = true;
      enableBookConversion = true;
      calibreLibrary = "/mnt/a/books";
    };
    package =
      pkgs.calibre-web.overridePythonAttrs (old: {
        dependencies = old.dependencies ++ old.optional-dependencies.kobo;
      });
    openFirewall = true;
    listen = {
      ip = "0.0.0.0";
      port = 8083;
    };
  };
}
