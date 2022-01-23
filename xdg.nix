{ config, lib, pkgs, ... }:

{
  xdg = {
    portal.enable = true;
    portal.wlr.enable = true;
    portal.gtkUsePortal = true;
  };
}
