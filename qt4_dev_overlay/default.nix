# before use run
# https://nixos.wiki/wiki/Development_environment_with_nix-shell
#
# nix-channel --add https://channels.nixos.org/nixos-23.05 nixpkgs-23.05
# nix-channel --update

{ pkgs ? import <nixpkgs> {} }:
let
  qt48 = pkgs.callPackage ./nixlib/qt48 {
    inherit (pkgs.gnome2) libgnomeui GConf gnome_vfs;
    inherit (pkgs.darwin) libobjc;
    inherit (pkgs.darwin.apple_sdk.frameworks) ApplicationServices OpenGL Cocoa AGL;
    cups = if pkgs.stdenv.isLinux then pkgs.cups else null;
    libmysqlclient = if (!pkgs.stdenv.isFreeBSD) then pkgs.libmysqlclient else null;
  };
in
  pkgs.mkShell {
    # mpi = openmp
    # nativeBuildInputs is usually what you want -- tools you need to run
    nativeBuildInputs = with pkgs.buildPackages; [ 
      gnumake git cmake neovim
      bison flex gcc11
      openssl gperftools
      patchelf

      tcl tcllib tclreadline tk readline
      eigen
      boost
      qt48
      ];
    shellHook = ''
      alias ll="ls -l"
      export FOO=bar
      export PROMPT='<maxdev>~$'
    '';
}

