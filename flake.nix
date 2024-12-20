{
  description = "Nix Bear";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = { 
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:pjones/plasma-manager";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    catppuccin.url = "github:catppuccin/nix";
    stylix.url = "github:danth/stylix";
  };

  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    plasma-manager,
    catppuccin,
    stylix,
    nixos-wsl,
    ...
  }:

  let
    
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    unstable = import nixpkgs-unstable {inherit system;};
  in {

    # System Configs
    nixosConfigurations = {
      nixos-wsl = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit unstable;};
        modules = [
      	  nixos-wsl.nixosModules.default {
            wsl.enable = true;
            wsl.defaultUser = "kenglish";
  	      }
          catppuccin.nixosModules.catppuccin
          stylix.nixosModules.stylix
          ./hosts/wsl.nix 
        ];
      };
      nixos-asm = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit unstable;};
        modules = [
          catppuccin.nixosModules.catppuccin
          stylix.nixosModules.stylix
          ./hosts/asm.nix 
        ];
      };
      terra = nixpkgs.lib.nixosSystem{
        inherit system;
        specialArgs = {inherit unstable catppuccin plasma-manager;};
        modules = [
          catppuccin.nixosModules.catppuccin
          stylix.nixosModules.stylix
          ./hosts/terra.nix
        ];
      };
      luna = nixpkgs.lib.nixosSystem{
        inherit system;
        specialArgs = {inherit unstable;};
        modules = [
          catppuccin.nixosModules.catppuccin
          stylix.nixosModules.stylix
          ./hosts/luna.nix
        ];
      };
      saturn = nixpkgs.lib.nixosSystem{
        inherit system;
        specialArgs = {inherit unstable;};
        modules = [
          catppuccin.nixosModules.catppuccin
          stylix.nixosModules.stylix
          ./hosts/saturn.nix
        ];
      };
      mercury = nixpkgs.lib.nixosSystem{
        inherit system;
        specialArgs = {inherit unstable;};
        modules = [
          catppuccin.nixosModules.catppuccin
          stylix.nixosModules.stylix
          ./hosts/mercury.nix
        ];
      };
      eunomia = nixpkgs.lib.nixosSystem{
        inherit system;
        specialArgs = {inherit unstable;};
        modules = [
          catppuccin.nixosModules.catppuccin
          stylix.nixosModules.stylix
          ./hosts/eunomia.nix
        ];
      };

    };

    homeConfigurations = {
      kenglish = home-manager.lib.homeManagerConfiguration { 
        inherit pkgs;
        extraSpecialArgs = {inherit unstable;};
        modules = [
          catppuccin.homeManagerModules.catppuccin
          #stylix.nixosModules.stylix
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
          #stylix.nixosModules.stylix
          ./home.nix
          ./home/solarbear-home.nix
        ];
      };
      solarbear-server = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
	      extraSpecialArgs = {inherit unstable;};
        modules = [
          catppuccin.homeManagerModules.catppuccin
          #stylix.nixosModules.stylix
          ./home.nix
          ./home/solarbear-server.nix
        ];
      };
    };
  };
}
