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
    })];
   environment.systemPackages = with pkgs;
        let
          R-with-pkgs = rWrapper.override{packages = with rPackages; [ggplot2 tidyverse];};
          #ollamagpu = pkgs.ollama.override { llama-cpp = (pkgs.llama-cpp.override {cudaSupport = false; openblasSupport = false; stdenv = gcc11Stdenv; }); };
          obsPlug = wrapOBS {
            plugins = with obs-studio-plugins; [
              wlrobs
            ];
          };
        in
          [
            #ollamagpu
            vim emacs ripgrep coreutils fd sqlite 
            wget git unzip # Basic tools
            vulkan-tools pulsemixer # vulkan,, audio mixer
            google-chrome  #librewolf #web browsers
            tor-browser-bundle-bin # Web browser p r i v a cy on ion
            clojure leiningen babashka clj-kondo clojure-lsp # Clojure dev
            #racket # Racket
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
            # minecraft
            prismlauncher
            # Java
            maven 
            wireguard-tools # VPN
            qbittorrent # Torrenting
            #R-with-pkgs # R/statistics
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
            #cling
            clang ccls # C++ Dev
            gcc gdb

            anki-bin # learning
            tesseract5 # OCR -> For manga, japanese
            #qutebrowser python39Packages.adblock # alternative web browser
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
            #filezilla # FTP GUI software
            zathura # PDF reading
            fluidsynth # midi for elona+
            mpd ncmpcpp
            # jack2 pavucontrol libjack2 jack2Full jack_capture
            # Pixelart
            #aseprite-unfree
            # Uni
            #teams
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
            #hikari river rivercarro
            wayvnc grim slurp weston mako
            waybar rofi-wayland wl-clipboard
            nomacs dunst swaybg
            weston
            cliphist

            # Virt
            virt-manager
            virglrenderer

            # Video edit
            ffmpeg-full

            # zip
            p7zip

            # BTRFS
            #btrfs-progs compsize
            # ssh
            ssh-askpass-fullscreen
            # Remote screen <-> Android
            scrcpy

#            openssl
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
            #legendary-gl rare heroic

            # cpu power
            #linuxKernel.packages.linux_xanmod.cpupower

            # monitor
            htop btop
            # Space
            ncdu

            #steam
            steamcmd

            # prolog
            #swiProlog scryer-prolog

            #julia
            #(fhsCommand "julia" "julia") (fhsCommand "julia-bash" "bash")
            #cairo
            distrobox
            #x11vnc
            #osu-lazer

            #bottles

            # Gaming more
            gamescope

            # chat
            #pidgin-with-plugins 

            i3lock
#            arch-install-scripts # Disabled, due to issues
            protontricks
            dosbox
            unar
            xboxdrv
            antimicrox


            #retroarchFull

            # Steam fix with xdg-desktop?
            libnma

            # Japanese
            # mecab python310Packages.pip
            # ASM
            vice
            # Deal with rar files in comfy wa
            rar2fs
            # math
            maxima

            # Ocaml
            opam ocaml
          ];

   #programs.steam.enable = true; # steam
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
 programs.steam = {
    enable = true;
    package = with pkgs; steam.override { extraPkgs = pkgs: [ attr ]; };
  };


 programs.adb.enable = true;
}
