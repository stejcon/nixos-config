{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.rofi = {
    enable = true;
    font = "JetBrainsMono Nerd Font 14";
  };
}
