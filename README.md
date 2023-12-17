START
======
https://github.com/LGUG2Z/nixos-wsl-starter


after Nixos installed
```
sudo nix-channel --add https://nixos.org/channels/nixos-23.11 nixos

git clone https://github.com/LGUG2Z/nixos-wsl-starter.git /tmp/configuration
sudo nixos-rebuild switch --flake ~/nix/nixos_wsl

```

explore
=======
https://www.reddit.com/r/NixOS/comments/boj9qw/how_to_use_overlays_with_nixshell/

```
{ pkgs ? import <nixpkgs> { overlays = [ (import ./nix_files/overlay.nix) ]; } }:
```


HOW develop works ?
===================

except home-manager
each folder represent a nix-shell (./default.nix) for it's develop enviroments)

# for use develop on older package
sudo nix-channel --add https://nixos.org/channels/nixos-23.05 nixpkgs-23.05
sudo nix-channel --update
