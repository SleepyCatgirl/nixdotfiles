{ config, lib, pkgs, ... }:

{
    # List packages installed in system profile. To search, run:
  # $ nix search wget

   environment.systemPackages = with pkgs;
        let
          R-with-pkgs = rWrapper.override{packages = with rPackages; [ggplot2 tidyverse];};
        in
          [
            vim emacs ripgrep coreutils fd clang sqlite # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
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
          ];

   programs.steam.enable = true;
}
