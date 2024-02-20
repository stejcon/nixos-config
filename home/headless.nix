{...}: {
  imports = [
    ./neovim
    ./git
    ./zsh
    ./lf
    ./zellij
    ./zoxide
    ./starship
    ./direnv
  ];

  home = {
    username = "stephen";
    homeDirectory = "/home/stephen";
    stateVersion = "23.11";
  };

  programs.home-manager.enable = true;
}
