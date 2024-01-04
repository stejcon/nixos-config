{...}:
{
  programs.zellij = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    settings = {
      pane_frames = false;
      #default_layout = "compact";
      mouse_mode = false;
      copy_command = "wl-copy";
      theme = "catppuccin-mocha";
    };
  };
}
