{
  description = "Home Manager configuration of ziyu4huang";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-old.url = "github:nixos/nixpkgs/nixos-23.05";
    nur.url = "github:nix-community/NUR";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    with inputs; let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

  unstable = import <nixos-unstable> { config = config.nixpkgs.config; };
  old = import <nixos-old> { config = config.nixpkgs.config; };
  nur = import <nur> { inherit pkgs; };


    in {
      nixpkgs.overlays = [
          nur.overlay
          (_final: prev: {
            # this allows us to reference pkgs.unstable
            unstable = import nixpkgs-unstable {
              inherit (prev) system;
            };
          })
          (_final: prev: {
            # this allows us to reference pkgs.unstable
            old = import nixpkgs-old {
              inherit (prev) system;
            };
          })
      ];


      homeConfigurations."ziyu4huang" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
