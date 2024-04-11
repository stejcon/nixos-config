{...}: {
  programs.zsh = {
    enable = true;
    autosuggestion = {
      enable = true;
    };
    autocd = true;
    syntaxHighlighting = {
      enable = true;
    };
    oh-my-zsh = {
      enable = true;
      theme = "simple";
    };
  };
}
