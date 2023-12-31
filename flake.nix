{
  description = "NixOS Dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:nixos/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {...}@inputs: let
    my-lib = import ./my-lib/default.nix {inherit inputs;};
    pkgs = my-lib.mkPkgs "x86_64-linux";
  in with my-lib; {
    formatter."x86_64-linux" = pkgs.alejandra;

    nixosConfigurations = {
      loki = mkMachine "x86_64-linux" ./hosts/loki/default.nix;
      thor = mkMachine "x86_64-linux" ./hosts/thor/default.nix;
    };

    homeConfigurations = {
      stephen = mkHome "x86_64-linux" ./home/default.nix;
    };
  };
}
