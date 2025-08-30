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
        grammars.tree-sitter-c
        grammars.tree-sitter-cpp
        grammars.tree-sitter-toml
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
