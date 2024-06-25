{
  imports = [
    ./cpp.nix
    ./rust.nix
    ./format.nix
    ./none-ls.nix
  ];

  programs.nixvim.plugins = {
    lsp = {
      enable = true;
      inlayHints = true;

      keymaps = {
        silent = true;
        diagnostic = {
          # Navigate in diagnostics
          "<leader>k" = "goto_prev";
          "<leader>j" = "goto_next";
        };

        lspBuf = {
          gd = "definition";
          gD = "references";
          gt = "type_definition";
          gi = "implementation";
          K = "hover";
          "<F2>" = "rename";
          "<F3>" = "code_action";
          "<leader>fm" = "format";
        };
      };

      servers = {
        lua-ls.enable = true;

        nil-ls = {
          enable = true;
          extraOptions.settings.nil = {
            nix.flake.autoArchive = true;
          };
        };

        pylsp = {
          enable = true;
          settings.plugins = {
            autopep8.enabled = false;
            pycodestyle.enabled = false;
            pyflakes.enabled = false;
            yapf.enabled = false;
            black = {
              enabled = false;
            };
            flake8 = {
              enabled = false;
              maxLineLength = 88;
            };
          };
        };
      };
    };
  };
}
