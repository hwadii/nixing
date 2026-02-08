{ config, pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
    extraPackages = epkgs: [
      epkgs.vterm
      epkgs.jinx
      epkgs.pdf-tools
      epkgs.tree-sitter-langs
      (epkgs.treesit-grammars.with-grammars (grammars: [
        grammars.tree-sitter-nix
        grammars.tree-sitter-nu
        grammars.tree-sitter-bash
        grammars.tree-sitter-css
        grammars.tree-sitter-c
        grammars.tree-sitter-cpp
        grammars.tree-sitter-toml
        grammars.tree-sitter-typst
        grammars.tree-sitter-scala
        grammars.tree-sitter-rust
        grammars.tree-sitter-go
        grammars.tree-sitter-ruby
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
