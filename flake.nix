{
  description = "NixOS Dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:nixos/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
        nix-darwin.follows = "";
        devshell.follows = "";
        treefmt-nix.follows = "";
        git-hooks.follows = "";
      };
    };

    waybar = {
      url = "github:Alexays/Waybar";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    matugen = {
      url = "github:InioX/matugen?ref=v2.2.0";
    };

    lix = {
      url = "https://git.lix.systems/lix-project/lix/archive/main.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/main.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.lix.follows = "lix";
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
