{
  description = "Nix Bear";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = { 
      url = "github:nix-community/home-manager";
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
    stylix.url = "github:danth/stylix/f121a142abde1b6aa9738e4c21a330c0ddd4eb70";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
  };

  outputs = {
    nixpkgs,
    home-manager,
    plasma-manager,
    nixos-wsl,
    stylix,
    chaotic,
    ...
  }:

  let
    
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {

    # System Configs
    nixosConfigurations = {
      nixos-wsl = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
      	  nixos-wsl.nixosModules.default {
            wsl.enable = true;
            wsl.defaultUser = "kenglish";
  	      }
          stylix.nixosModules.stylix
          ./hosts/wsl.nix 
        ];
      };
      nixos-asm = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          stylix.nixosModules.stylix
          ./hosts/asm.nix 
        ];
      };
      terra = nixpkgs.lib.nixosSystem{
        inherit system;
        specialArgs = {inherit plasma-manager;};
        modules = [
          stylix.nixosModules.stylix
          chaotic.nixosModules.default
          ./hosts/terra.nix
        ];
      };
      luna = nixpkgs.lib.nixosSystem{
        inherit system;
        modules = [
          stylix.nixosModules.stylix
          ./hosts/luna.nix
        ];
      };
      saturn = nixpkgs.lib.nixosSystem{
        inherit system;
        modules = [
          stylix.nixosModules.stylix
          ./hosts/saturn.nix
        ];
      };
      mercury = nixpkgs.lib.nixosSystem{
        inherit system;
        modules = [
          stylix.nixosModules.stylix
          ./hosts/mercury.nix
        ];
      };
      eunomia = nixpkgs.lib.nixosSystem{
        inherit system;
        modules = [
          stylix.nixosModules.stylix
          ./hosts/eunomia.nix
        ];
      };

    };

    homeConfigurations = {
      kenglish = home-manager.lib.homeManagerConfiguration { 
        inherit pkgs;
        modules = [
          ./home.nix
          ./home/kenglish-home.nix
        ];
      };
      solarbear = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          plasma-manager.homeManagerModules.plasma-manager
          ./home.nix
          ./home/solarbear-home.nix
        ];
      };
      solarbear-server = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
          ./home/solarbear-server.nix
        ];
      };
    };
  };
}
