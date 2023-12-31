{inputs}: rec {
  mkPkgs = sys: (import inputs.nixpkgs {
    system = "${sys}";
    config = {allowUnfree = true;};
  });

  mkHome = sys: config:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = mkPkgs sys;
      extraSpecialArgs = {
        inherit inputs;
      };
      modules = [
        config
      ];
    };

  mkMachine = sys: host:
    inputs.nixpkgs.lib.nixosSystem {
      pkgs = mkPkgs sys;
      specialArgs = {
        inherit inputs;
        system = sys;
      };
      modules = [
        host
        ../configuration.nix
      ];
    };
}
