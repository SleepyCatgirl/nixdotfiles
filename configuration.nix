# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
#      ./fonts.nix
      ./nix.nix
      ./audio.nix
      ./input.nix
      ./software.nix
      ./networking.nix
      ./desktop.nix
      ./xdg.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";
  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };
  #
  i18n.defaultLocale = "en_US.UTF-8";
  # Enable the X11 windowing system.
  services.xserver.enable = true;

    fonts.fonts = with pkgs; [
    ipafont
    kochi-substitute
    source-code-pro
    carlito
    dejavu_fonts
  ];
  fonts.fontconfig.defaultFonts = {
    monospace = [
      "DejaVu Sans Mono"
      "IPAGothic"
    ];
    sansSerif = [
      "DejaVu Sans"
      "IPAPGothic"
    ];
    serif = [
      "DejaVu Serif"
      "IPAPMincho"
    ];
  };


 #suspend
#  services.logind.lidSwitch = "suspend";
#  services.logind.lidSwitchDocked = "suspend";
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
     extraGroups = [ "jackaudio" "wheel" "networkmanage" "audio" "video" "libvirtd" ]; # Enable ‘sudo’ for the user.
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
  services.xserver.videoDrivers = [ "amdgpu" "intel" ];
  boot.initrd.kernelModules = [ "snd-seq" "snd-rawmidi" "amdgpu" ];
  hardware.firmware = with pkgs; [
	firmwareLinuxNonfree
	];
  virtualisation.libvirtd.enable = true;
  hardware.opengl = {
	enable = true;
	driSupport32Bit = true;
	driSupport = true;
  extraPackages = with pkgs; [
    libva1
  ];


  };

  #Postgresql
  services.postgresql = {
    enable = true;
    enableTCPIP = true;
        authentication = pkgs.lib.mkOverride 10 ''
      local all all trust
      host all all ::1/128 trust
    '';
    initialScript = pkgs.writeText "backend-initScript" ''
      CREATE ROLE nixcloud WITH LOGIN PASSWORD 'nixcloud' CREATEDB;
      CREATE DATABASE nixcloud;
      GRANT ALL PRIVILEGES ON DATABASE nixcloud TO nixcloud;
    '';
  };

}
