# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "ehci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "ssdPool/root";
      fsType = "zfs";
    };

  fileSystems."/home" =
    { device = "ssdPool/home";
      fsType = "zfs";
    };

  fileSystems."/nix" =
    { device = "ssdPool/local/nix";
      fsType = "zfs";
    };
  fileSystems."/run/media/HDD" =
    { device = "hddPool/hdd";
      fsType = "zfs";
    };
  fileSystems."/run/media/HDD/Games/Oblivion" =
    { device = "hddPool/oblivion";
      fsType = "zfs";
    };
  fileSystems."/run/media/HDD/Games/STALKERSoC" =
    { device = "hddPool/STALKERSoC";
      fsType = "zfs";
    };
  fileSystems."/run/media/HDD/.var" =
    { device = "hddPool/flatpak";
      fsType = "zfs";
    };

  fileSystems."/home/senchou/.WoT" =
    { device = "ssdPool/WoWs";
      fsType = "zfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/9AA8-C873";
      fsType = "vfat";
    };

  swapDevices = [ ];

}
