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
outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }:
  let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    unstable = import nixpkgs-unstable {inherit system;};
#    unstable = nixpkgs-unstable.legacyPackages.${system};
  in {
    
    nixosConfigurations = {
      nixos-asm = lib.nixosSystem {
        inherit system;
        specialArgs = {inherit unstable;};
        modules = [
          ./configuration.nix
          ./hosts/asm.nix 
          ./hosts/asm-hardware.nix
        ];
      };
      luna = lib.nixosSystem{
        inherit system;
	#inherit nixpkgs-unstable;
        specialArgs = {inherit unstable;};
        modules = [
          ./configuration.nix
          ./hosts/luna.nix
          ./hosts/luna-hardware.nix
        ];
      };
    };

    homeConfigurations = {
      kenglish = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {inherit unstable;};
        modules = [
          ./home.nix
          ./home/asm-home.nix
        ];
      };
      solarbear = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
	extraSpecialArgs = {inherit unstable;};
        modules = [
          ./home.nix
          ./home/luna-home.nix
        ];
      };
    };
  };
}
