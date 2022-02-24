{ config, lib, pkgs, ... }:

{

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = false;
  services.xserver.displayManager.startx.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  environment.gnome.excludePackages = [ pkgs.gnome.cheese pkgs.gnome.gnome-music pkgs.evince pkgs.gnome.gnome-characters pkgs.gnome.totem
                                      ];
  services.xserver.windowManager.bspwm.enable = true;


}
