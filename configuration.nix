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
      #./container.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  systemd.services.systemd-udev-settle.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # Set your time zone.
  time.timeZone = "Europe/Warsaw";
  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };
  #
  i18n.defaultLocale = "en_US.UTF-8";
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    # enable wacom support
    # wacom.enable = true;
  };
    fonts.packages = with pkgs; [
    ipafont
    kochi-substitute
    source-code-pro
    carlito
    dejavu_fonts
    siji
    scientifica
    rounded-mgenplus
    hanazono
    cherry
    font-awesome
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
    memoryPercent = 100;
    priority = 180;
    algorithm = "lz4";
  };
  boot.kernel.sysctl = { "vm.swappiness" = 180;
			 "vm.watermark_boost_factor" = 0;
		 	 "vm.watermark_scale_factor" = 125;
			 "vm.page-cluster" = 0;};
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
     extraGroups = [ "jackaudio" "wheel" "networkmanage" "audio" "video" "libvirtd" "docker" "adbusers" ]; # Enable ‘sudo’ for the user.
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
   services.openssh.enable = true;
#  services.openssh.settings.permitRootLogin = "yes";
#   services.sshd.enable = true;

  # Open ports in the firewall.
   networking.firewall.allowedTCPPorts = [ 5900 9993 42000 42001 ];
   networking.firewall.allowedUDPPorts = [ 5900 9993 42000 42001 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  # Logitech mouse
  services.ratbagd.enable = true;
  #ZFS
  boot.kernelParams = [ "zfs.zfs_arc_max=3120000000" "nohibernate" "mitigations=off" "nvidia-drm.modeset=1" ]; # ZFS hibernating issue
  boot.kernelModules = [ "kvm-intel" "binder_linux" "ashmem_linux" ]; # kvm waydroid
  boot.extraModprobeConfig = ''
                           options binder_linux devices=binder,hwbinder,vndbinder
'';
  boot.initrd.supportedFilesystems = ["zfs"];
  boot.supportedFilesystems = ["zfs"];
  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages; # Latest ZFS kernel
  #boot.kernelPackages = pkgs.linuxPackages_xanmod; # Waydroid
  #boot.kernelPackages = pkgs.linuxPackages_zen; # Waydroid
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
  # services.xserver.videoDrivers = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.vulkan_beta;
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
  };
  ## Separate boot for stable
  specialisation = {
    vulkanBeta.configuration = {
      system.nixos.tags = ["stable"];
      hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };


  boot.initrd.kernelModules = [ "snd-seq" "snd-rawmidi" ];
  hardware.firmware = with pkgs; [
	firmwareLinuxNonfree
	];
  # Virtualization
  virtualisation.libvirtd.enable = true;
  virtualisation.vmware.host.enable = true;
  #virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "senchou" "root" ];
  hardware.opengl = {
	enable = true;
	driSupport32Bit = true;
	driSupport = true;
  extraPackages = with pkgs; [
    libva1
    # Fix for vulkan renderer wayland
    vulkan-validation-layers
#    mesa.opencl
#    rocm-opencl-icd
#    rocm-opencl-runtime
  ];

  };

  security.sudo.wheelNeedsPassword = false;
  # Waydroid
  virtualisation.waydroid.enable = false;
  # docker
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless.enable = true;
  virtualisation.docker.rootless.setSocketVariable = true;
  virtualisation.docker.enableNvidia = true;
  virtualisation.docker.storageDriver = "zfs";
  #Postgresql
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_16;
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
  services.flatpak.enable = true;
  #boot.zfs.extraPools = [ "hddPool" ];
  boot.zfs.forceImportAll = true;

  # sh script

  environment.binsh = "${pkgs.dash}/bin/dash";
  hardware.opentabletdriver.enable = true;

  services =
    {
      syncthing = {
        enable = true;
        user = "senchou";
        configDir = "/home/senchou/.config/syncthing";
      };
    };

  services.teamviewer.enable = true;

  # Fix insecure thingy
  nixpkgs.config.permittedInsecurePackages = [
    "python-2.7.18.6"
    "openssl-1.1.1u"
  ];
	
  programs.criu.enable = true;
  hardware.xone.enable = true;

  # polkit
  security.polkit.enable = true;
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

}
