{ config, lib, pkgs, ... }:

{
    # List packages installed in system profile. To search, run:
  # $ nix search wget
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = "https://github.com/nix-community/emacs-overlay/archive/f3c435a5e5cfa3ce1b2f50ba37b9cacfec4139d9.tar.gz";
      sha256 = "1k91djyfmwyb3hs0i60cvchyzvb3d5g2jhyb3mrnzs0rjr7siprj";
    }))];
   environment.systemPackages = with pkgs;
        let
          R-with-pkgs = rWrapper.override{packages = with rPackages; [ggplot2 tidyverse];};
        in
          [
            vim emacsPgtk ripgrep coreutils fd clang sqlite # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
            wget git unzip # Basic tools
            vulkan-tools google-chrome discord pulsemixer # web browser, chat, audio mixer
            clojure clojure-lsp leiningen # Clojure dev
            gcc gdb # C++ Dev
            cabal-install haskell-language-server ghc # Haskell dev
            dmenu pywal polybarFull bspwm sxhkd # WM aesthics
            gnome.gnome-tweaks # Gnome aesthics
            openvpn # Uni.
            mullvad-vpn # VPN
            openjdk # Java run
            wireguard # VPN
            qbittorrent # Torrenting
            R-with-pkgs
            scrot xclip # screenshoting and putting them in copy paste
            nethack cool-retro-term # gaming
            angband crawl           # gameeeess
            steam-run-native        # FHS enviroment
            wineWowPackages.staging # WINE
            winetricks
            texlive.combined.scheme-full
            mpv play-with-mpv yt-dlp # Download youtube and play em
            git-crypt # sensitive information like GPG keys via .git
            piper # logitech libratbagd GTK frontend
            # For configuring them
            virglrenderer # 3D Render for VMs
            cling ccls # C++ Dev
            anki # learning
            qutebrowser python39Packages.adblock
            # Books
            kepubify calibre
            xorg.xhost
            sbcl
          ];
   programs.steam.enable = true;
}
