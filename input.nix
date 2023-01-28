{ config, lib, pkgs, ... }:

{

  # Japanese input
  # fcitx as IME
  i18n.inputMethod = {
    enabled = "fcitx";
    # mozc
    fcitx.engines = with pkgs.fcitx-engines; [ mozc ];

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
