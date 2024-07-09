{
  pkgs,
  lib,
  ...
}: {
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
        kitty +kitten icat --clear --stdin no --silent --transfer-mode file < /dev/null > /dev/tty
      '';
      previewer = pkgs.writeShellScriptBin "preview.sh" ''
        file=$1
        w=$2
        h=$3
        x=$4
        y=$5

        if [[ "$( file -Lb --mime-type "$file")" =~ ^image ]]; then
            kitty +kitten icat --silent --stdin no --transfer-mode file --place "''${w}x''${h}@''${x}x''${y}" "$file" < /dev/null > /dev/tty
            exit 1
        fi

        ${lib.getExe pkgs.pistol} "$file"
      '';
    in ''
      set cleaner ${cleaner}/bin/clean.sh
      set previewer ${previewer}/bin/preview.sh
      cmd stripspace %stripspace "$f"
    '';
  };
}
