{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    adwaita-fonts
    atkinson-hyperlegible-next
    atkinson-hyperlegible-mono
    dejavu_fonts
    newcomputermodern
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    source-code-pro
    source-sans-pro
    work-sans
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      emoji = [ "Noto Color Emoji" ];
      monospace = [
        "Atkinson Hyperlegible Mono"
        "DejaVu Sans Mono"
      ];
      sansSerif = [
        "Work Sans"
        "DejaVu Sans"
      ];
    };
  };
}
