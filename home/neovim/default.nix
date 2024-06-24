{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./settings.nix
    ./autocomplete.nix
    ./autocommands.nix
    ./plugins
  ];

  programs.nixvim = {
    enable = true;
    colorschemes = {
      catppuccin = {
        enable = true;
        settings = {
          flavour = "mocha";
          show_end_of_buffer = true;
        };
      };
    };
    plugins = {
      which-key = {
        enable = true;
      };
      fidget = {
        enable = true;
      };
      gitsigns = {
        enable = true;
      };
      notify = {
        enable = true;
      };
      neorg = {
        enable = true;
        lazyLoading = true;
        modules = {
          "core.defaults" = {
            __empty = null;
          };
          "core.concealer" = {
            __empty = null;
          };
          "core.completion" = {
            config = {
              engine = "nvim-cmp";
            };
          };
          "core.summary" = {
            __empty = null;
          };
        };
      };
      typst-vim = {
        enable = true;
        settings = {
          cmd = "${pkgs.typst}/bin/typst";
          concealMath = true;
          pdfViewer = "${pkgs.zathura}/bin/zathura";
        };
      };
      none-ls = {
        enable = true;
        sources = {
          code_actions = {
            statix = {
              enable = true;
            };
          };
          diagnostics = {
            ltrs = {
              enable = true;
            };
            statix = {
              enable = true;
            };
          };
          formatting = {
            alejandra = {
              enable = true;
            };
          };
        };
      };
    };
    keymaps = [
      {
        key = "<Space>";
        action = "<NOP>";
        options.silent = true;
      }
      {
        key = "<Esc>";
        mode = ["n"];
        action = ":noh<CR><ESC>";
        options.silent = true;
      }
      {
        key = "<Space>h";
        mode = ["n"];
        action = "<C-w>h";
        options.desc = "Window: Focus left";
      }
      {
        key = "<Space>j";
        mode = ["n"];
        action = "<C-w>j";
        options.desc = "Window: Focus down";
      }
      {
        key = "<Space>k";
        mode = ["n"];
        action = "<C-w>k";
        options.desc = "Window: Focus up";
      }
      {
        key = "<Space>l";
        mode = ["n"];
        action = "<C-w>l";
        options.desc = "Window: Focus right";
      }
      {
        key = "<leader>w";
        mode = ["n"];
        action = ":silent! TypstWatch<CR>";
        options.desc = "Typst Watch";
      }
    ];
    extraPlugins = with pkgs.vimPlugins; [
      nvim-web-devicons
      no-neck-pain-nvim
    ];
  };
}
