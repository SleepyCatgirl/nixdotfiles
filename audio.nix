{ config, lib, pkgs, ... }:

{
    # Enable sound.
  # sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
    socketActivation = true;
  };
  services.jack = {
    jackd.enable = false;
  };
  # Bluetooth
  hardware.bluetooth.enable = true;
  # hardware.bluetooth.package = pkgs.bluezFull;
  services.blueman.enable = true;
}
