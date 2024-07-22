{pkgs, ...}: {
  gtk = {
    enable = true;
    theme = {
      name = "rose-pine-gtk";
      package = pkgs.rose-pine-gtk-theme;
    };
    iconTheme = {
      name = "rose-pine-icons";
      package = pkgs.rose-pine-gtk-theme;
    };
  };
}
