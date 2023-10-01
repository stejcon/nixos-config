{
  description = "NixOS Dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:nixos/nixos-hardware";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    nixpkgs,
    home-manager,
    nixos-hardware,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    formatter.${system} = pkgs.alejandra;

    nixosConfigurations = {
      # Laptop setup
      loki = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          ./hosts/loki/hardware-configuration.nix
          nixos-hardware.nixosModules.framework-12th-gen-intel
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useUserPackages = true;
              useGlobalPkgs = true;
              users.stephen = ./home;
            };
          }
        ];
      };

      # Desktop setup
      thor = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          ./hosts/thor/hardware-configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useUserPackages = true;
              useGlobalPkgs = true;
              users.stephen = ./home;
            };
          }
        ];
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
