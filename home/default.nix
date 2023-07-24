{ config, pkgs, ... }:

{
  imports = [ ./neovim ./kitty ./tmux ./git ./rofi ./picom ./awesomewm ];

  home.username = "stephen";
  home.homeDirectory = "/home/stephen";
  home.stateVersion = "22.11";
}
