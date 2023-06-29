{ config, lib, pkgs, ... }:

{
  xdg.portal.enable = lib.mkForce false;
  xdg.portal.gtkUsePortal = false;
  services.dbus.enable = true;
}
