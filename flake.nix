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
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
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
      	  nixos-wsl.nixosModules.default
          stylix.nixosModules.stylix
          ./hosts/wsl/wsl.nix 
        ];
      };
      terra = nixpkgs.lib.nixosSystem{
        inherit system;
        specialArgs = {inherit plasma-manager;};
        modules = [
          stylix.nixosModules.stylix
          chaotic.nixosModules.default
          ./hosts/terra/terra.nix
        ];
      };
      luna = nixpkgs.lib.nixosSystem{
        inherit system;
        modules = [
          stylix.nixosModules.stylix
          ./hosts/luna/luna.nix
        ];
      };
      saturn-manager = nixpkgs.lib.nixosSystem{
        inherit system;
        modules = [
          stylix.nixosModules.stylix
          ./hosts/saturn/manager.nix
        ];
      };
      saturn-gpu = nixpkgs.lib.nixosSystem{
        inherit system;
        modules = [
          stylix.nixosModules.stylix
          ./hosts/saturn/gpu.nix
        ];
     };
     mercury-manager = nixpkgs.lib.nixosSystem{
        inherit system;
        modules = [
          stylix.nixosModules.stylix
          ./hosts/mercury/manager.nix
        ];
      };
      jupiter-manager = nixpkgs.lib.nixosSystem{
        inherit system;
        modules = [
          stylix.nixosModules.stylix
          ./hosts/jupiter/manager.nix
        ];
      };
    };

    homeConfigurations = {
      kenglish = home-manager.lib.homeManagerConfiguration { 
        inherit pkgs;
        modules = [
          ./home/schema/kenglish.nix
        ];
      };
      solarbear = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          plasma-manager.homeManagerModules.plasma-manager
          ./home/schema/solarbear.nix
        ];
      };
      solarbear-server = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home/schema/server.nix
        ];
      };
    };
  };
}
