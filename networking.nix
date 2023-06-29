{ config, lib, pkgs, ... }:

{

  networking.hostName = "nix"; # Define your hostname.
  networking.wireless.enable = false;  # Enables wireless support via wpa_supplicant.
  services.mullvad-vpn.enable = true;
  programs.gamemode.enable = true;
  networking.firewall.checkReversePath = "loose";
  networking.wireguard.enable = true;
  networking.iproute2.enable = true;
  nix.settings.auto-optimise-store = true; # Optimize for space
  networking.networkmanager.enable = true;

  # mesh VPN
  services.zerotierone.enable = true;
  services.tailscale.enable = true;


  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";


}
