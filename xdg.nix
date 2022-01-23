{ config, lib, pkgs, ... }:

{
  xdg = {
    portal.enable = true;
    portal.wlr.enable = true;
    portal.gtkUsePortal = true;
    portal.extraPortals = with pkgs; [
      xdg-desktop-portal-gtk ];
  };
}
