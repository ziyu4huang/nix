# before use run
# nixpkgs https://channels.nixos.org/nixos-23.11
# nix-channel --add https://channels.nixos.org/nixos-23.05 nixpkgs-23.05
# https://nixos.wiki/wiki/Development_environment_with_nix-shell
# nix-channel --update

{ pkgs ? import <nixpkgs-23.05> {} }:
  pkgs.mkShell {
    # mpi = openmp
    # nativeBuildInputs is usually what you want -- tools you need to run
    nativeBuildInputs = with pkgs.buildPackages; [ 
      gnumake git cmake neovim
      bison flex
      gcc11 bazel
      openmpi openssl

      tcl tcllib tclreadline tk readline
      eigen
      boost 
      qt4
      ];
    shellHook = ''
      alias ll="ls -l"
      export FOO=bar
    '';
}

