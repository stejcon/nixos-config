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
        action = ":silent! TypstWatch<cr>";
      }
    ];

    plugins = {
      lsp.servers.tinymist = {
        enable = true;
      };

      typst-vim = {
        enable = true;
        settings = {
          conceal_math = true;
          auto_open_quickfix = false;
          pdf_viewer = "zathura";
        };
      };
    };
  };
}
