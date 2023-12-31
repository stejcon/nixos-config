{inputs}: let
  my-lib = (import ./default.nix) {inherit inputs;};
in rec {
  mkPkgs = sys: (import inputs.nixpkgs {
    system = "${sys}";
    config = {allowUnfree = true;};
  });

  forAllSystems = inputs.nixpkgs.lib.genAttrs [
    "x86_64-linux"
    "aarch64-linux"
    "x86_64-darwin"
    "aarch64-darwin"
  ];

  mkHome = sys: config:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = mkPkgs sys;
      extraSpecialArgs = {
        inherit inputs my-lib;
      };
      modules = [
        config
      ];
    };

  mkMachine = sys: host:
    inputs.nixpkgs.lib.nixosSystem {
      pkgs = mkPkgs sys;
      specialArgs = {
        inherit inputs my-lib;
        system = sys;
      };
      modules = [
        host
        ../configuration.nix
      ];
    };
}
