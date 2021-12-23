{ config, lib, pkgs, ... }:
{
    fonts.fonts = with pkgs; [
    ipafont
    kochi-substitute
    source-code-pro
    carlito
    dejavu_fonts
  ];
  fonts.fontconfig.defaultFonts = {
    monospace = [
      "DejaVu Sans Mono"
      "IPAGothic"
    ];
    sansSerif = [
      "DejaVu Sans"
      "IPAPGothic"
    ];
    serif = [
      "DejaVu Serif"
      "IPAPMincho"
    ];
  };


}
