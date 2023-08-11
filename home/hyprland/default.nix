{ config, pkgs, lib, ... }:

{
  xdg.configFile.hypr = {
<<<<<<< HEAD
    source = ./config;
    recursive = true;
=======
    source = ./hyprland.conf;
>>>>>>> 2e63043 (Added starting hyprland conf)
  };
}
