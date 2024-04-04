{
description = "Test flake";
inputs = {
  nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
  home-manager = {
    url = "github:nix-community/home-manager/release-23.11";
    inputs.nixpkgs.follows = "nixpkgs";
  };
};
outputs = { self, nixpkgs, home-manager, ... }:
  let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    
    nixosConfigurations = {
      nixos-asm = lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          ./hosts/asm.nix 
          ./hosts/asm-hardware.nix
        ];
      };
      luna = lib.nixosSystem{
        inherit system;
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
        modules = [
          ./home.nix
          ./hosts/asm-home.nix
        ];
      };
      solarbear = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
          ./hosts/luna-home.nix
        ];
      };
    };
  };
}
