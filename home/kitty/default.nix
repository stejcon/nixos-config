{ config, pkgs, lib, ... }: {
  programs.kitty = {
    enable = true;
    font.name = "JetBrainsMono Nerd Font Mono";
    font.size = 8;
    extraConfig = ''
      background #1E1D23
      foreground #DED7D0

      selection_foreground #1A1B1F
      selection_background #CFD0D7

      cursor #DFE0EA
      cursor_text_color background

      active_tab_background #E85A84
      active_tab_foreground #DFE0EA
      active_tab_font_style bold
      inactive_tab_background #342D3B
      inactive_tab_foreground #CFD0D7
      inactive_tab_font_style italic

      # Black
      color0 #938884
      color8 #938884

      # Red
      color1 #FF7DA3
      color9 #FF7DA3

      # Green
      color2 #7EC49D
      color10 #7EC49D

      # Yellow
      color3 #EFD472
      color11 #EFD472

      # Blue
      color4 #8BB8D0
      color12 #8BB8D0

      # Magenta
      color5 #BDA9D4
      color13 #BDA9D4

      # Cyan
      color6 #BDA9D4
      color14 #BDA9D4

      # White
      color7 #DED7D0
      color15 #DED7D0
    '';
  };
}
