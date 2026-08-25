{ config, pkgs, ... }:

{
  imports = [
    ../tools/shell.nix
    ../tools/git.nix
    ../tools/ssh.nix
    ./emacs.nix
  ];

  home.username = "wadii";
  home.homeDirectory = "/Users/wadii";

  home.sessionVariables = {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
  };

  home.packages = with pkgs; [
    claude-code-bin
    cmake
    delta
    enchant
    fd
    mise
    nixfmt-rfc-style
    ripgrep
    unzip
  ];

  home.stateVersion = "25.05";
}
