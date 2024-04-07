{
description = "Test flake";
inputs = {
  nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
  nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  home-manager = {
    url = "github:nix-community/home-manager/release-23.11";
    inputs.nixpkgs.follows = "nixpkgs";
  };
};
outputs = { nixpkgs, nixpkgs-unstable, home-manager, ... }:
  let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    pkgs = nixpkgs.legacyPackages.${system};
    unstable = import nixpkgs-unstable {inherit system; config = { allowUnfree = true; }; };
  in {
    nixosConfigurations = {
      nixos-asm = lib.nixosSystem {
        inherit system;
        specialArgs = {inherit unstable;};
        modules = [
          ./configuration.nix
          ./hosts/asm.nix 
        ];
      };
      terra = lib.nixosSystem{
        inherit system;
	#inherit nixpkgs-unstable;
        specialArgs = {inherit unstable;};
        modules = [
          ./configuration.nix
          ./hosts/terra.nix
        ];
      };
      luna = lib.nixosSystem{
        inherit system;
	#inherit nixpkgs-unstable;
        specialArgs = {inherit unstable;};
        modules = [
          ./configuration.nix
          ./hosts/luna.nix
        ];
      };
    };

    homeConfigurations = {
      kenglish = home-manager.lib.homeManagerConfiguration { 
        inherit pkgs;
        extraSpecialArgs = {inherit unstable;};
        modules = [
          ./home.nix
          ./home/kenglish-home.nix
        ];
      };
      solarbear = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
	extraSpecialArgs = {inherit unstable;};
        modules = [
          ./home.nix
          ./home/solarbear-home.nix
        ];
      };
    };
  };
}
