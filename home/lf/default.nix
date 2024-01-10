{pkgs, ...}: {
  xdg.configFile."lf/icons".source = ./icons;

  programs.lf = {
    enable = true;
    commands = {
      drag-out = ''%${pkgs.ripdrag}/bin/ripdrag -a -x "$fx"'';
      editor-open = ''$$EDITOR "$f"'';
      edit-dir = ''$$EDITOR .'';
    };

    keybindings = {
      "\\\"" = "";
      o = "";
      d = "";
      e = "";
      f = "";

      "." = "set hidden!";
      D = "delete";
      p = "paste";
      dd = "cut";
      y = "copy";
      "<enter>" = "open";
      a = "rename";
      r = "reload";
      C = "clear";
      U = "unselect";
      do = "drag-out";

      ee = "editor-open";
      "e." = "edit-dir";
      V = ''''$${pkgs.bat}/bin/bat --paging=always --theme=gruvbox "$f"'';

      "<C-d>" = "5j";
      "<C-u>" = "5k";
    };

    settings = {
      preview = true;
      hidden = true;
      drawbox = true;
      icons = true;
      ignorecase = true;
    };

    extraConfig = let
      cleaner = pkgs.writeShellScriptBin "clean.sh" ''
        ${pkgs.ctpv}/bin/ctpvclear
        ${pkgs.kitty}/bin/kitty +kitten icat --clear --stdin no --silent --transfer-mode file < /dev/null > /dev/tty
      '';
    in ''
      # set cleaner ''${pkgs.ctpv}/bin/ctpvclear
      set cleaner ${cleaner}/bin/clean.sh
      set previewer ${pkgs.ctpv}/bin/ctpv
      cmd stripspace %stripspace "$f"
    '';
  };
}
