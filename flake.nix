{
  description = "A very basic flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  inputs = { };
  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let system = "x86_64-linux";
    in {
      nixosConfigurations.sul = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.sul = {
              imports = [ inputs.nixvim.homeManagerModules.nixvim ./home.nix ];
            };
          }
          ./configuration.nix
        ];
      };
    };
}
