{
  description = "Nix Bear";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = { 
      url = "github:nix-community/home-manager/release-24.05";
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
  };

  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    plasma-manager,
    catppuccin,
    nixos-wsl,
    ...
  }:

  let
    
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    unstable = import nixpkgs-unstable {inherit system;};
    authorized_keys= [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKUHyx/4I3LxcmzRp9d1+MLd4lt0RyctsiqyfOnBXSXl solarbear@terra"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHxtCabfWGBSoEY4spPRPJLAAT6dM22ElBdnoxCiPDlU kenglish@nixos-asm"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFuTwUDCM3+GaHuXkLMGYFeRqCcCHuhOblydZhMzmWrn kenglish@nixos-wsl"
    ];

  in {

    # System Configs
    nixosConfigurations = {
      nixos-wsl = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit unstable;};
        modules = [
      	  nixos-wsl.nixosModules.default {
    	      system.stateVersion = "24.05";
            wsl.enable = true;
            wsl.defaultUser = "kenglish";
  	      }
          catppuccin.nixosModules.catppuccin
          ./hosts/wsl.nix 
        ];
      };
      nixos-asm = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit unstable;};
        modules = [
          catppuccin.nixosModules.catppuccin
          ./hosts/asm.nix 
        ];
      };
      terra = nixpkgs.lib.nixosSystem{
        inherit system;
        specialArgs = {inherit unstable authorized_keys;};
        modules = [
          catppuccin.nixosModules.catppuccin
          ./hosts/terra.nix
        ];
      };
      luna = nixpkgs.lib.nixosSystem{
        inherit system;
        specialArgs = {inherit unstable;};
        modules = [
          catppuccin.nixosModules.catppuccin
          ./hosts/luna.nix
        ];
      };
      saturn = nixpkgs.lib.nixosSystem{
        inherit system;
        specialArgs = {inherit unstable;};
        modules = [
          catppuccin.nixosModules.catppuccin
          ./hosts/saturn.nix
        ];
      };
      mercury = nixpkgs.lib.nixosSystem{
        inherit system;
        specialArgs = {inherit unstable;};
        modules = [
          catppuccin.nixosModules.catppuccin
          ./hosts/mercury.nix
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
      solarbear-server = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
	      extraSpecialArgs = {inherit unstable;};
        modules = [
          catppuccin.homeManagerModules.catppuccin
          ./home.nix
          ./home/solarbear-server.nix
        ];
      };
    };
  };
}
