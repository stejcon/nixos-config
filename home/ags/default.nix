{
  inputs,
  pkgs,
  osConfig,
  ...
}: {
  imports = [inputs.ags.homeManagerModules.default];

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme.override {color = "nordic";};
    };
  };

  programs.ags = {
    enable = true;

    configDir = ./config;

    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
      sassc
    ];
  };

  home.packages = with pkgs; [sassc];
}
