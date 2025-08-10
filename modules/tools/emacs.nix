{ config, pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
    extraPackages = epkgs: [
      epkgs.vterm
      epkgs.tree-sitter-langs
      (epkgs.treesit-grammars.with-grammars (grammars: [
        grammars.tree-sitter-nix
        grammars.tree-sitter-nu
        grammars.tree-sitter-bash
        grammars.tree-sitter-css
      ]))
    ];
  };

  services.emacs = {
    enable = true;
    client.enable = true;
    defaultEditor = true;
    startWithUserSession = true;
  };

  xdg.configFile."emacs" = {
    source = ../../config/emacs;
    recursive = true;
  };
}
