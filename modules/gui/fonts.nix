{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    adwaita-fonts
    aporetic-bin
    dejavu_fonts
    iosevka-bin
    jetbrains-mono
    julia-mono
    newcomputermodern
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      emoji = [ "Noto Color Emoji" ];
      monospace = [
        "Berkeley Mono"
        "DejaVu Sans Mono"
      ];
      sansSerif = [
        "Adwaita Sans"
        "DejaVu Sans"
      ];
    };
  };
}
