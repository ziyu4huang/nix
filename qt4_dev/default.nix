# https://nixos.wiki/wiki/Development_environment_with_nix-shell

{ pkgs ? import <nixpkgs-23.05> {} }:
  pkgs.mkShell {
    # nativeBuildInputs is usually what you want -- tools you need to run
    nativeBuildInputs = with pkgs.buildPackages; [ 
      bison
      flex
      qt4
      ];
    shellHook = ''
      alias ll="ls -l"
      export FOO=bar
    '';
}

