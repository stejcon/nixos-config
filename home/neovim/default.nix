{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./settings.nix
    ./autocomplete.nix
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
        enableLspFormat = true;
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
      lsp-format = {
        enable = true;
      };
      lsp = {
        enable = true;
        keymaps = {
          diagnostic = {
            gl = {
              action = "open_float";
              desc = "Diagnostic: Open Float";
            };
            "[d" = {
              action = "goto_prev";
              desc = "Diagnostic: Go To Previous";
            };
            "]d" = {
              action = "goto_next";
              desc = "Diagnostic: Go To Next";
            };
          };
          lspBuf = {
            K = {
              action = "hover";
              desc = "LSP: Hover";
            };
            gD = {
              action = "references";
              desc = "LSP: Go to References";
            };
            gd = {
              action = "definition";
              desc = "LSP: Go to Definition";
            };
            gi = {
              action = "implementation";
              desc = "LSP: Go to Implementation";
            };
            gt = {
              action = "type_definition";
              desc = "LSP: Type Definition";
            };
            gs = {
              action = "signature_help";
              desc = "LSP: Signature Help";
            };
            "<F2>" = {
              action = "rename";
              desc = "LSP: Rename Variable";
            };
            "<F4>" = {
              action = "code_action";
              desc = "LSP: Code Action";
            };
            "<leader>fm" = {
              action = "format";
              desc = "LSP: Format";
            };
          };
        };
        servers = {
          clangd.enable = true;
          rust-analyzer = {
            enable = true;
            installRustc = false;
            installCargo = false;
          };
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
                enabled = true;
              };
              flake8 = {
                enabled = true;
                maxLineLength = 88;
              };
            };
          };
          typst-lsp.enable = true;
          bashls.enable = true;
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
    autoCmd = [
      {
        event = ["FileType"];
        pattern = ["typst"];
        command = "silent! TypstWatch";
      }
    ];
  };

  home.packages = with pkgs; [
    ripgrep # Needed for Telescope live_grep
  ];
}
