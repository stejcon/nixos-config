{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      typst
    ];
  };

  programs.nixvim = {
    files."after/ftplugin/typst.lua".keymaps = [
      {
        mode = "n";
        key = "<leader>w";
        action = ":TypstWatch<cr>";
        options = {
          desc = "Typst Watch";
          silent = true;
        };
      }
    ];

    plugins = {
      lsp.servers.tinymist = {
        enable = true;
      };

      typst-vim = {
        enable = true;
        settings = {
          conceal_math = 1;
          auto_open_quickfix = false;
          pdf_viewer = "zathura";
        };
      };
    };
  };
}
