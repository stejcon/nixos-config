{pkgs, ...}: {
  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.rose-pine-cursor;
      name = "BreezeX-RoséPine";
    };
    theme = {
      package = pkgs.rose-pine-gtk-theme;
      name = "rose-pine-gtk";
    };
    iconTheme = {
      package = pkgs.rose-pine-icon-theme;
      name = "rose-pine-icons";
    };
  };
}
