{...}:
{
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    settings = {
      format = "$directory$git_branch$git_metrics$fill$nix_shell\n$character";

      palette = "catppuccin_mocha";

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
    } // builtins.fromTOML (builtins.readFile ./mocha.toml);

  };
}
