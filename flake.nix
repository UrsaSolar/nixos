{
description = "Test flake";
inputs = {
  nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
  nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  home-manager = {
    url = "github:nix-community/home-manager/release-23.11";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  plasma-manager = {
    url = "github:pjones/plasma-manager";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.home-manager.follows = "home-manager";
  };
  catppuccin.url = "github:catppuccin/nix";
};
outputs = { nixpkgs, nixpkgs-unstable, home-manager, plasma-manager, catppuccin, ... }:
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
        specialArgs = {inherit unstable;};
        modules = [
          ./configuration.nix
          ./hosts/terra.nix
        ];
      };
      luna = lib.nixosSystem{
        inherit system;
        specialArgs = {inherit unstable;};
        modules = [
          catppuccin.nixosModules.catppuccin
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
          catppuccin.homeManagerModules.catppuccin
          ./home.nix
          ./home/kenglish-home.nix
        ];
      };
      solarbear = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
	      extraSpecialArgs = {inherit unstable;};
        modules = [
          plasma-manager.homeManagerModules.plasma-manager
          catppuccin.homeManagerModules.catppuccin
          ./home.nix
          ./home/solarbear-home.nix
        ];
      };
    };
  };
}
