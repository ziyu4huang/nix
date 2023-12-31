#
# cd < THIS FOLDER>
# nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz home-manager
# nix-channel --update
{
  description = "Home Manager configuration of ziyu4huang";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs_unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs_old.url = "github:nixos/nixpkgs/nixos-23.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };


  outputs = { nixpkgs, home-manager, ... }@input:
    let
      username = "ziyu4huang";
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {

      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        #inherit pkgs_old;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
