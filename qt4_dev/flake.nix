{
  description = "Example Python development environment for Zero to Nix";
  nixConfig.bash-prompt = "\[qt4-dev\]$ ";

  # Flake inputs
  inputs = {
    #nixpkgs.url = "github:NixOS/nixpkgs"; # also valid: "nixpkgs"
    #nixpkgs.url = "https://nixos.org/channels/nixos-22.05";
    #https://channels.nixos.org/nixos-23.11 nixpkgs
    #nixpkgs.url = "channel:nixos-22.05";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05"; # also valid: "nixpkgs"
  };

  # Flake outputs
  outputs = {
    self,
    nixpkgs,
  }: let
    # Systems supported
    allSystems = [
      "x86_64-linux" # 64-bit Intel/AMD Linux
    ];

    # Helper to provide system-specific attributes
    forAllSystems = f:
      nixpkgs.lib.genAttrs allSystems (system:
        f {
          pkgs = import nixpkgs {inherit system;};
        });
  in {
    # Development environment output
    devShells = forAllSystems ({pkgs}: {
      default = let
        # Use Python 3.11 # fail to compile cython
        # Use Python 3.10, is ok with gcc
        python = pkgs.python310;
        qt = pkgs.qt4;
        tcl = pkgs.tcl;
        boost = pkgs.boost;
        bison = pkgs.bison;
        flex= pkgs.flex;
        tclreadline = pkgs.tclreadline;
      in
        pkgs.mkShell {
          # The Nix packages provided in the environment
          packages = [
            # Python plus helper tools
            (python.withPackages (ps:
              with ps; [
                numpy
                pip
              ]))
            qt
            boost
            tcl
            tclreadline
            bison
            flex
          ];
        };
    });
  };
}
