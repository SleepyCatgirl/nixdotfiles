{ config, lib, pkgs, ... }:

{
  xdg.portal = {
	enable = true;
	#extraPortals = [pkgs.xdg-desktop-portal-gtk];
};

#  xdg.portal.enable = lib.mkForce false;
#  xdg.portal.gtkUsePortal = lib.mkForce false;
  services.dbus.enable = true;
}
