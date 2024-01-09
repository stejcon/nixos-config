{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.kitty = {
    enable = true;
    font.name = "JetBrainsMono Nerd Font Mono";
    font.size = 14;
    theme = "Catppuccin-Mocha";
    extraConfig = ''
      active_tab_font_style bold
      inactive_tab_font_style italic
      confirm_os_window_close 0
    '';
  };
}
