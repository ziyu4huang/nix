{
  description = "Example Python development environment for Zero to Nix";

  # Flake inputs
  inputs = {
    #nixpkgs.url = "github:NixOS/nixpkgs"; # also valid: "nixpkgs"
    #nixpkgs.url = "https://nixos.org/channels/nixos-22.05";
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
        # Use Python 3.11
        gcc = pkgs.gcc;
        python = pkgs.python310;
      in
        pkgs.mkShell {
          # The Nix packages provided in the environment
          packages = [
            # Python plus helper tools
            (python.withPackages (ps:
              with ps; [
                numpy
              ]))
          ];
        };
    });
  };
}
