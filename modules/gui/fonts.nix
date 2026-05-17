{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    adwaita-fonts
    aporetic-bin
    atkinson-hyperlegible-next
    dejavu_fonts
    fantasque-sans-mono
    input-fonts
    iosevka-bin
    jetbrains-mono
    julia-mono
    lexend
    newcomputermodern
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    source-code-pro
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      emoji = [ "Noto Color Emoji" ];
      monospace = [
        "Berkeley Mono Variable"
        "DejaVu Sans Mono"
      ];
      sansSerif = [
        "Adwaita Sans"
        "DejaVu Sans"
      ];
    };
  };
}
