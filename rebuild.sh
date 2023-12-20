#!/usr/bin/env bash
nixos-rebuild boot --use-remote-sudo --flake '/home/senchou/.nixdotfiles#senchou-desktop'
