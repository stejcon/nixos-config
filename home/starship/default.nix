{...}:
{
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    settings = {
      format = "$directory$git_branch$git_metrics$fill$nix_shell";

      fill = {
        symbol = " ";
      };

      nix_shell = {
        symbol = "❄️";
        format = "[$symbol $name]($style)";
      };

      git_metrics = {
        disabled = false;
      };
    };
  };
}
