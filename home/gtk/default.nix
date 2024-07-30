{pkgs, ...}: {
  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
    };
    theme = {
      package = pkgs.adw-gkt3;
      name = "adw-gtk3";
    };
    iconTheme = {
      package = pkgs.gruvboxPlus;
      name = "GruvboxPlus";
    };
  };
}
