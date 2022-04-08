{ config, lib, pkgs, ... }:

{
  xdg = {
    portal.enable = true;
    portal.wlr.enable = true;
  };
  services.dbus.enable = true;
}
