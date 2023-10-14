{
  home-manager,
  nixpkgs,
  system ? "x86_64-linux",
  extraModules ? [],
}:
home-manager.lib.homeManagerConfiguration {
  pkgs = import nixpkgs {inherit system;};
  modules = [../home.nix] ++ extraModules;
}
