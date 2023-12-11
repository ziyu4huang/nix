How to install home-manager
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
