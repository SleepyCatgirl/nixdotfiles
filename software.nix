{ config, lib, pkgs, ... }:

{
    # List packages installed in system profile. To search, run:
  # $ nix search wget
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = "https://github.com/nix-community/emacs-overlay/archive/f3c435a5e5cfa3ce1b2f50ba37b9cacfec4139d9.tar.gz";
      sha256 = "1k91djyfmwyb3hs0i60cvchyzvb3d5g2jhyb3mrnzs0rjr7siprj";
    }))
    (self: super: {
      # jack support for mpv
      mpv = super.wrapMpv (super.mpv.unwrapped.override {jackaudioSupport = true;}) {};
      # emacs with Xwidgets and GTK3
      emacsPgtk = super.emacsPgtk.override {
        withXwidgets = true;
        withGTK3 = true;};})];
   environment.systemPackages = with pkgs;
        let
          R-with-pkgs = rWrapper.override{packages = with rPackages; [ggplot2 tidyverse];};
          waydroidPython = python-packages: with python-packages; [
            tqdm
            requests
          ];
          pidgin-with-plugins = pkgs.pidgin.override {
            plugins = [purple-discord];
          };
#          ffmpeg-jack = ffmpeg-full.overrideAttrs (oldAttrs: rec {libjack2 = true;});
          wayPython = python3.withPackages waydroidPython;
          obsPlug = wrapOBS {
            plugins = with obs-studio-plugins; [
              wlrobs
            ];
          };
        in
          [
            vim emacsPgtk ripgrep coreutils fd sqlite 
            wget git unzip # Basic tools
            vulkan-tools pulsemixer # vulkan,, audio mixer
            google-chrome librewolf #web browsers
            tor-browser-bundle-bin # Web browser p r i v a cy on ion
            clojure leiningen babashka clj-kondo clojure-lsp # Clojure dev
            racket # Racket
            cabal-install haskell-language-server ghc stack# Haskell dev
            haskellPackages.haskell-language-server
            haskellPackages.hoogle
            xmobar
            dmenu pywal polybarFull bspwm sxhkd # WM aesthics
            unrar-wrapper # unrar
            gnome.gnome-tweaks # Gnome aesthics
            openvpn # Uni.
            mullvad-vpn # VPN
            openjdk # Java run
            wireguard-tools # VPN
            qbittorrent # Torrenting
            R-with-pkgs # R/statistics
            scrot xclip # screenshoting and putting them in copy paste
            nethack cool-retro-term # gaming
            angband crawl           # gameeeess
            steam-run-native        # FHS enviroment
            wineWowPackages.staging # WINE
            winetricks              # WINE
            texlive.combined.scheme-full # LaTeX stuff, pdfs etc
            mpv play-with-mpv yt-dlp # Download youtube and play em
            git-crypt # sensitive information like GPG keys via .git
            piper # logitech libratbagd GTK frontend
            # For configuring them
            virglrenderer # 3D Render for VMs
            cling clang ccls # C++ Dev
            gcc gdb

            anki-bin # learning
            tesseract5 # OCR -> For manga, japanese
            qutebrowser python39Packages.adblock # alternative web browser
            kepubify calibre # Books
            xorg.xhost
            sbcl # Common Lisp compiler
            xcolor # Color picker Xorg
            libvterm cmake gnumake libtool # Terminal emulator library for vterm
            #obs-studio # Streaming/Discord
            discord
            obsPlug
            qjackctl jack_capture carla # JACK software
            easyeffects # audio
            filezilla # FTP GUI software
            zathura # PDF reading
            fluidsynth # midi for elona+
            mpd ncmpcpp
            # jack2 pavucontrol libjack2 jack2Full jack_capture
            # Pixelart
            aseprite-unfree
            # Uni
            teams
            # Image manipulation/view
	          feh
            imagemagick
            # NTFS user space 
            ntfs3g
            # UEFI 
            OVMFFull
            # Gaming
            lutris
            # waydroid
            #waydroid 
            #wayPython
            lzip lxc

            # Wayland
            hikari river rivercarro wayvnc grim slurp weston
            waybar rofi-wayland wl-clipboard
            nomacs dunst swaybg

            # Virt
            virt-manager
            virglrenderer

            # Video edit
            ffmpeg-full

            # zip
            p7zip

            # BTRFS
            btrfs-progs compsize
            # ssh
            ssh-askpass-fullscreen
            # Remote screen <-> Android
            scrcpy

            openssl
            # sync
            syncthing

            # fuse
            fuse fuse3

            #Codecs
            mpg123 gst_all_1.gstreamer gst_all_1.gst-plugins-bad
            gst_all_1.gst-plugins-ugly gst_all_1.gst-plugins-good gst_all_1.gst-plugins-base
            # Mangohud!
            mangohud
            # For appimages
            appimage-run
            ncurses ncurses5
            parallel


            # Manga
            hakuneko
            # zip
            zip

            # Epic gl
            legendary-gl rare heroic

            # cpu power
            linuxKernel.packages.linux_xanmod.cpupower

            # monitor
            htop bpytop
            # Space
            ncdu

            #steam
            steamcmd

            # prolog
            swiProlog scryer-prolog

            #julia
            #(fhsCommand "julia" "julia") (fhsCommand "julia-bash" "bash")
            #cairo
            distrobox
            x11vnc
            osu-lazer

            bottles

            # Fcitx qt support
            fcitx5-gtk libsForQt5.fcitx-qt5

            # Gaming more
            gamescope

            # chat
            pidgin-with-plugins ripcord

            i3lock
          ];

   programs.steam.enable = true; # steam
#   nixpkgs.config.packageOverrides = pkgs: {
#     steam = pkgs.steam.override {
#       extraPkgs = pkgs: with pkgs; [
#         keyutils
#         libkrb5
#         libpng
#         libpulseaudio
#         libvorbis
#         stdenv.cc.cc.lib
#         xorg.libXcursor
#         xorg.libXi
#         xorg.libXinerama
#         xorg.libXScrnSaver
#       ];
#     };
#   };
   programs.adb.enable = true;
}
