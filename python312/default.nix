# before use run
# https://nixos.wiki/wiki/Development_environment_with_nix-shell
#
# nix-channel --add https://channels.nixos.org/nixos-23.05 nixpkgs-23.05
# nix-channel --update

{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
    # mpi = openmp
    # nativeBuildInputs is usually what you want -- tools you need to run
    nativeBuildInputs = with pkgs.buildPackages; [ 
    pkg-config
    gcc openssl gdbm readline 
    ncurses bzip2 lzma sqlite
    gnumake 
    # _ctype --> ffi, nis-> libnsl
    libuuid libffi
    #nis
    libnsl 
    openssl

    #_crypt
    libxcrypt
   
    
    neovim
    patchelf

    tcl tcllib tclreadline tk readline
      ];
    shellHook = ''
      alias ll="ls -l"
      export FOO=bar
      export PROMPT='<maxdev>~$'
    '';
}

