{ machine, ... }:

{
  imports = [ 
    ./neovim 
    ./kitty 
    ./tmux 
    ./git 
    ./rofi 
    ./picom 
    ./awesomewm 
    ./hyprland { inherit machine; }
  ];

  home.username = "stephen";
  home.homeDirectory = "/home/stephen";
  home.stateVersion = "22.11";
}
