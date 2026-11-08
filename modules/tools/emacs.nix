{ config, pkgs, pkgs-unstable, ... }:

{
  home.packages = [ pkgs.imagemagick ];

  programs.emacs = {
    enable = true;
    package = (pkgs-unstable.emacsPackagesFor pkgs-unstable.emacs31-gtk3).emacsWithPackages (epkgs: [
      # TODO: uncomment when it gets published to nixpkgs
      # epkgs.emureader
      epkgs.ghostel
      epkgs.jinx
      epkgs.tree-sitter-langs
      epkgs.treesit-grammars.with-all-grammars
    ]);
  };

  services.emacs = {
    enable = true;
    client.enable = true;
    defaultEditor = true;
    startWithUserSession = "graphical";
  };

  xdg.configFile."emacs" = {
    source = ../../config/emacs;
    recursive = true;
  };
}
