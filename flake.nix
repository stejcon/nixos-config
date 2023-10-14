{
  description = "NixOS Dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.config.allowUnfree = true;

    nixos-hardware.url = "github:nixos/nixos-hardware";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixos-hardware,
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    mkMachine = import ./lib/mkMachine.nix;
  in {
    formatter.${system} = pkgs.alejandra;

    nixosConfigurations = {
      # Laptop setup
      loki = mkMachine {
        inherit nixpkgs home-manager;
        name = "loki";
        extraModules = [
          nixos-hardware.nixosModules.framework-12th-gen-intel
        ];
      };

      # Desktop setup
      thor = mkMachine {
        inherit nixpkgs home-manager;
        name = "thor";
      };
    };

    homeConfigurations = {
      stephen = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [./home];
      };
    };
  };
}
