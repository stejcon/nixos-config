{
  programs.nixvim = {
    plugins.oil = {
      enable = true;
      settings = {
        columns = [
          "icon"
          "permissions"
          "size"
          "mtime"
        ];
        view_options = {
          show_hidden = true;
        };
        constrain_cursor = "name";
        delete_to_trash = true;
        use_default_keymaps = true;
        preview = {
          border = "rounded";
        };
        float = {
          padding = 2;
          maxWidth = ''math.ceil(vim.o.lines * 0.8 - 4)'';
          maxHeight = ''math.ceil(vim.o.columns * 0.8)'';
          border = "rounded";
          winOptions = {
            winblend = 0;
          };
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "-";
        action = ":Oil --float<CR>";
        options = {
          desc = "Open parent directory";
          silent = true;
        };
      }
    ];
  };
}
