# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./fonts.nix
      ./nix.nix
      ./audio.nix
      ./input.nix
      ./software.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nix"; # Define your hostname.
  networking.wireless.enable = false;  # Enables wireless support via wpa_supplicant.
  services.mullvad-vpn.enable = true;
  programs.gamemode.enable = true;
  networking.firewall.checkReversePath = "loose";
  networking.wireguard.enable = true;
  networking.iproute2.enable = true;
  nix.autoOptimiseStore = true; # Optimize for space
  networking.networkmanager.enable = true;	
  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };
  #
  # fonts
  #
  i18n.defaultLocale = "en_US.UTF-8";
  # Enable the X11 windowing system.
  services.xserver.enable = true;

 #suspend
#  services.logind.lidSwitch = "suspend";
#  services.logind.lidSwitchDocked = "suspend";

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = false;
  services.xserver.displayManager.startx.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  environment.gnome.excludePackages = [ pkgs.gnome.cheese pkgs.gnome.gnome-music pkgs.evince pkgs.gnome.gnome-characters pkgs.gnome.totem
                                      ];
 services.xserver.windowManager.bspwm.enable = true;

  zramSwap = {
    enable = true;
    memoryPercent = 110;
    numDevices = 1;
  };
  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
#  services.xserver.libinput = {
#	enable = true;
#	touchpad = {
#		accelProfile = "flat";
#		disableWhileTyping = false;
#		};
#	};
#
  # battery saving
   #  services.tlp.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.senchou = {
     isNormalUser = true;
     extraGroups = [ "wheel" "networkmanage" "audio" "video" "libvirtd" ]; # Enable ‘sudo’ for the user.
     home = "/home/senchou";
   };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
   programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
     pinentryFlavor = "curses";
   };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  # Logitech mouse
  services.ratbagd.enable = true;
  #ZFS
  boot.kernelParams = [ "zfs.zfs_arc_max=326870912" "nohibernate" "mitigations=off" ]; # ZFS hibernating issue
  boot.kernelModules = [ "kvm-intel" ]; # kvm
  boot.initrd.supportedFilesystems = ["zfs"];
  boot.supportedFilesystems = ["zfs"];
boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  services.udev.extraRules = ''
    ACTION=="add|change", KERNEL=="sd[a-z]*[0-9]*|mmcblk[0-9]*p[0-9]*|nvme[0-9]*n[0-9]*p[0-9]*", ENV{ID_FS_TYPE}=="zfs_member", ATTR{../queue/scheduler}="none"
''; # zfs already has its own scheduler. without this my(@Artturin) computer froze for a second when i nix build something.
  networking.hostId = "027f2f84";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?
  # Hardwar accel etc
  services.xserver.videoDrivers = [ "amdgpu" ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  hardware.firmware = with pkgs; [
	firmwareLinuxNonfree
	];
  virtualisation.libvirtd.enable = true;
  hardware.opengl = {
	enable = true;
	driSupport32Bit = true;
	driSupport = true;
  };



}
