{ config, lib, pkgs, ... }:

{

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = false;
  services.xserver.displayManager.startx.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  environment.gnome.excludePackages = [ pkgs.gnome.cheese pkgs.gnome.gnome-music pkgs.evince pkgs.gnome.gnome-characters pkgs.gnome.totem pkgs.xdg-desktop-portal-gnome
                                      ];
  services.xserver.windowManager.bspwm.enable = true;
  services.xserver.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    extraPackages = haskellPackages: [
      haskellPackages.dbus
      haskellPackages.xmonad
      haskellPackages.xmobar
    ];
  };

  
  nixpkgs.config.bitlbee.enableLibPurple = true;
  
  services.bitlbee = {
    enable = true;
    libpurple_plugins = [
      pkgs.purple-discord
      # all plugins: `nix-env -qaP | grep purple-`
    ];
  };
  services.gvfs.enable = true;
}
