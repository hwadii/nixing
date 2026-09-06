{ config, pkgs, pkgs-unstable, ... }:

{
  home.packages = [ pkgs.imagemagick ];

  programs.emacs = {
    enable = true;
    package = pkgs-unstable.emacs31-gtk3;
    extraPackages = epkgs: [
      epkgs.ghostel
      epkgs.jinx
      epkgs.pdf-tools
      epkgs.transient
      epkgs.tree-sitter-langs
      epkgs.treesit-grammars.with-all-grammars
    ];
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
