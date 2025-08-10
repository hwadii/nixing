{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    adwaita-fonts
    jetbrains-mono
    dejavu_fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      emoji = [ "Noto Color Emoji" ];
      monospace = [ "Berkeley Mono" "DejaVu Sans Mono" ];
      sansSerif = [ "Adwaita Sans" "DejaVu Sans" ];
    };
  };
}
