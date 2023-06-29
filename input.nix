{ config, lib, pkgs, ... }:

{

  # Japanese input
  # fcitx as IME
  i18n.inputMethod = {
    enabled = "fcitx5";
    # mozc
    #fcitx.engines = with pkgs.fcitx-engines; [ mozc ];
    fcitx5.addons = with pkgs;
      [
        ibus-engines.mozc
        fcitx5-mozc
        fcitx5-gtk
        libsForQt5.fcitx5-qt
      ];

    # For wayland and such
    # enabled = "ibus";
    # ibus.engines = with pkgs.ibus-engnies; [ mozc ];
  };

#  i18n.inputMethod = {
#    enabled = "fcitx5";
#    fcitx5.addons = with pkgs; [
#      fcitx5-mozc
#      fcitx5-gtk
#    ];
#  };
}
