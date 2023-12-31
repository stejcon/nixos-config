{
  description = "NixOS Dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:nixos/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    split-monitor-workspaces = {
      url = "github:Duckonaut/split-monitor-workspaces";
      inputs.hyprland.follows = "hyprland";
    };
  };

  outputs = {...} @ inputs: let
    my-lib = import ./my-lib/default.nix {inherit inputs;};
  in
    with my-lib; {
      formatter = forAllSystems (system: inputs.nixpkgs.legacyPackages.${system}.alejandra);

      nixosConfigurations = {
        loki = mkMachine "x86_64-linux" ./hosts/loki/default.nix;
        thor = mkMachine "x86_64-linux" ./hosts/thor/default.nix;
      };

      homeConfigurations = {
        stephen = mkHome "x86_64-linux" ./home/default.nix;
      };
    };
}
