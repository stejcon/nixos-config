{...}: {
  programs.kitty = {
    enable = true;
    font.name = "JetBrainsMono Nerd Font Mono";
    font.size = 11;
    theme = "Catppuccin-Mocha";
    settings = {
      active_tab_font_style = "bold";
      inactive_tab_font_style = "italic";
      confirm_os_window_close = 0;
    };
  };
}
