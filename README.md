
SIMPLE start use nix and build placer
=====================================

```
source start_nix.sh

# for package use 
#  nix-shell -p bash 

# for package use 
#  nix-shell -p home-manager

# or develop 
# cd build_placer
nix-shell build_env.nix

for CUDA
========
export LIBRARY_PATH=/usr/local/cuda-12.3/lib64:/usr/local/cuda-12.3/targets/x86_64-linux/lib/stubs
export CPATH=/usr/local/cuda-12.3/include
```


START NIXOS WSL
=================
https://github.com/LGUG2Z/nixos-wsl-starter


after Nixos installed
```
sudo nix-channel --add https://nixos.org/channels/nixos-23.11 nixos

git clone https://github.com/LGUG2Z/nixos-wsl-starter.git /tmp/configuration
sudo nixos-rebuild switch --flake ~/nix/nixos_wsl

```
START NIX package manager
==========================
```
sh <(curl -L https://nixos.org/nix/install) --no-daemon
```


HOW develop works ?
===================

except home-manager
each folder represent a nix-shell (./default.nix) for it's develop enviroments)

# for use develop on older package
sudo nix-channel --add https://nixos.org/channels/nixos-23.05 nixpkgs-23.05
sudo nix-channel --update

START : How to install home-manager
==============================

https://nix-community.github.io/home-manager/index.xhtml#ch-installation

Nixpkgs version 23.11 channel you can run

nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz home-manager
nix-channel --update

Run the Home Manager installation command and create the first Home Manager generation:

nix-shell '<home-manager>' -A install

If you do not plan on having Home Manager manage your shell configuration then you must source the

#$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
# in #$HOME/..profile

if [ -e $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh ]; then . $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh; fi # for nix home-manager

Develop local pkgs 
====================

git clone https://github.com/NixOS/nixpkgs.git

# option 1
nix-shell -I nixpkgs=/path/to/your/nixpkgs --pure -p packageName

# option 2

```
export NIX_PATH=nixpkgs=/path/to/your/nixpkgs:$NIX_PATH
nix-shell --pure -p packageName
```

# option 3

or just direct modify the channel directory
ls -al ~/.nix-defexpr/channels/


explore overlage
==========
https://www.reddit.com/r/NixOS/comments/boj9qw/how_to_use_overlays_with_nixshell/

```
{ pkgs ? import <nixpkgs> { overlays = [ (import ./nix_files/overlay.nix) ]; } }:
```


build python
============
./configure --enable-shared LDFLAGS="-Wl,-rpath='\$\$ORIGIN/../lib'" \ 
	--prefix=${HOME}/python312  --enable-optimizations
