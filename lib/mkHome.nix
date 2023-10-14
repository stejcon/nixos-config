{
  home-manager,
  nixpkgs,
  system ? "x86_64-linux",
}:
home-manager.lib.homeManagerConfiguration {
  pkgs = import nixpkgs {inherit system;};
  modules = [../home.nix];
}
