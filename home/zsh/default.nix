{...}: {
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    autocd = true;
    syntaxHighlighting = {
      enable = true;
    };
    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
    };
  };
}
