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
      oil = {
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
        };
      };
      fidget = {
        enable = true;
      };
      treesitter = {
        enable = true;
        folding = true;
        indent = true;
        incrementalSelection.enable = true;
      };
      treesitter-context = {
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
      comment = {
        enable = true;
        settings = {
          opleader = {
            line = "<C-b>";
          };
          toggler = {
            line = "<C-b>";
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
      telescope = {
        enable = true;
        keymaps = {
          "<leader>ff" = {
            action = "find_files";
            options = {
              desc = "Telescope: Find Files";
            };
          };
          "<leader>fg" = {
            action = "live_grep";
            options = {
              desc = "Telescope: Live Grep";
            };
          };
          "<leader>fb" = {
            action = "buffers";
            options = {
              desc = "Telescope: Buffers";
            };
          };
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
        key = "-";
        action = '':lua require("oil").open_float()<CR>'';
        mode = ["n"];
        options.desc = "Oil: Open Floating Window";
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

  home.packages = with pkgs; [
    ripgrep # Needed for Telescope live_grep
  ];
}
