{...}:
{
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    settings = {
      format = "$directory$git_branch$git_metrics$fill$nix_shell";

      fill = {
        symbol = "";
      };

      nix_shell = {
        format = "[$symbol$state( \($name\))]($style)";
      };
    };
  };
}
