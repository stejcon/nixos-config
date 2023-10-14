{
  name,
  system ? "x86_64-linux",
  nixpkgs,
  home-manager,
  extraArgs ? {},
  extraModules ? [],
}:
nixpkgs.lib.nixosSystem {
  inherit system;

  modules =
    [
      ../hosts/${name}
      ../configuration.nix
      home-manager.nixosModules.home-manager
      {
        home-manager = {
          useUserPackages = true;
          useGlobalPkgs = true;
          users.stephen = ../home;
        };
      }
    ]
    ++ extraModules;

  specialArgs =
    {
      inherit nixpkgs;
    }
    // extraArgs;
}
