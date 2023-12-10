{
  description = "Example Python development environment for Zero to Nix";
  nixConfig.bash-prompt = "\[pytorch\]$ ";

  # Flake inputs
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs"; # also valid: "nixpkgs"
    #nixpkgs.url = "https://nixos.org/channels/nixos-22.05";
    #nixpkgs.url = "channel:nixos-22.05";
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11"; # also valid: "nixpkgs"
    #nixpkgs.url = "https://channels.nixos.org/nixos-23.11";
  };

  # Flake outputs
  outputs = {
    self,
    nixpkgs,
  }: let
    # Systems supported
    allSystems = [
      "x86_64-linux" # 64-bit Intel/AMD Linux
      "aarch64-linux" # 64-bit ARM Linux
      "x86_64-darwin" # 64-bit Intel macOS
      "aarch64-darwin" # 64-bit ARM macOS
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
        lunarvim = pkgs.lunarvim;
        git = pkgs.git;
        tcl = pkgs.tcl;
        boost = pkgs.boost;
        bison = pkgs.bison;
        flex= pkgs.flex;
        gcc = pkgs.gcc;
        tclreadline = pkgs.tclreadline;
      in
        pkgs.mkShell {
          # The Nix packages provided in the environment
          packages = [
            # Python plus helper tools
            (python.withPackages (ps:
              with ps; [
                pip
                pandas
                jupyterlab
                lunarvim
              ]))
	    gcc
	    git
	    lunarvim
          ];
        };
    });
  };
}
