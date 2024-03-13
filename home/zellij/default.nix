{...}: {
  programs.zellij = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    settings = {
      pane_frames = false;
      # TODO: Once I'm familiar with keybinds, add this as it adds some screenspace
      # default_layout = "compact";
      mouse_mode = false;
      copy_command = "wl-copy";
      theme = "catppuccin-mocha";
      simplified_ui = true;
      default_mode = "locked";
    };
  };

  programs.zsh.initExtraFirst = ''export ZELLIJ_AUTO_ATTACH="true"'';
}
