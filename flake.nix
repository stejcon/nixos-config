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
    # FIXME: Temporarily changed url until upstream is fixed
    split-monitor-workspaces = {
      url = "github:bivsk/split-monitor-workspaces/bivsk";
      inputs.hyprland.follows = "hyprland";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: let
    my-lib = import ./my-lib/default.nix {inherit inputs;};
  in
    with my-lib; rec {
      formatter = forAllSystems (system: inputs.nixpkgs.legacyPackages.${system}.alejandra);

      packages = {
        "aarch64-linux".default = homeConfigurations.stephen-pi.activationPackage;
      };

      apps = {
        "aarch64-linux".default = {
          type = "app";
          program = "${packages.aarch64-linux.default}/activate";
        };
      };

      nixosConfigurations = {
        loki = mkMachine "x86_64-linux" ./hosts/loki/default.nix;
        thor = mkMachine "x86_64-linux" ./hosts/thor/default.nix;
      };

      homeConfigurations = {
        stephen = mkHome "x86_64-linux" ./home/default.nix;
        stephen-pi = mkHome "aarch64-linux" ./home/headless.nix;
      };
    };
}
