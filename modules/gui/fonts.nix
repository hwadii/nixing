{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    adwaita-fonts
    atkinson-hyperlegible-mono
    atkinson-hyperlegible-next
    maple-mono.Normal-Variable
    maple-mono.NormalNL-OTF
    newcomputermodern
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
