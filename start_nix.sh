# install nix: README.md
# sh <(curl -L https://nixos.org/nix/install) --no-daemon
# install home-manager/flake.nix

if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
if [ -e $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh ]; then . $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh; fi # for nix home-manager


echo "#use below command to start nix-shell"
echo "nix-shell -p bash"
echo "nix-shell -p home-manager"
