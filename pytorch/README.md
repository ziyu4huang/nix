Install CUDA WSL-Ubuntu
=====================
https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&Distribution=WSL-Ubuntu&target_version=2.0&target_type=deb_local


=================
# first change channdle ,  this is only availible for 22.05 now
$> nix-channel --add https://nixos.org/channels/nixos-22.05 nixpkgs
$> nix-shell -p qt4

# it will update , nixpkgs as default
see ~/.nix-channels
https://nixos.org/channels/nixos-22.05 nixpkgs


use this config to 
LD_LIBRARY_PATH=/nix/store/myw67gkgayf3s2mniij7zwd79lxy8v0k-gcc-12.3.0-lib/lib:/usr/lib/wsl:/usr/lib/wsl/lib python
