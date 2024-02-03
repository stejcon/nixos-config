{...}: {
  imports = [./neovim ./kitty ./tmux ./git ./hyprland ./bluetooth ./zsh ./waybar ./lf ./zellij ./zoxide ./starship];

  home.username = "stephen";
  home.homeDirectory = "/home/stephen";
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;
}
