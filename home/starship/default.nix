{...}:
{
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    settings = {
      format = "$directory$git_branch$git_metrics$fill$direnv";
    };
  };
}
