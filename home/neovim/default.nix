{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.nixvim.homeManagerModules.nixvim];

  programs.nixvim = {
    enable = true;
    clipboard.providers.wl-copy.enable = true;
    # TODO remove when neovim 0.10 is out as this should be the default behavior
    filetype.extension.typ = "typst";
    colorschemes = {
      catppuccin = {
        enable = true;
        settings = {
          flavour = "mocha";
          show_end_of_buffer = true;
        };
      };
    };
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };
    opts = {
      backup = false;
      clipboard = "unnamedplus";
      completeopt = ["menu" "menuone" "noselect"];
      conceallevel = 0;
      hlsearch = true;
      ignorecase = true;
      smartcase = true;
      pumheight = 10;
      showmode = false;
      showtabline = 0;
      shiftwidth = 4;
      tabstop = 4;
      expandtab = true;
      splitbelow = true;
      splitright = true;
      swapfile = true;
      termguicolors = true;
      timeout = true;
      timeoutlen = 300;
      undofile = true;
      updatetime = 300;
      writebackup = false;
      backupcopy = "yes";
      cursorline = true;
      relativenumber = true;
      numberwidth = 2;
      signcolumn = "auto";
      wrap = false;
      scrolloff = 8;
      sidescrolloff = 8;
      laststatus = 3;
      cmdheight = 0;
      mouse = "";
      foldcolumn = "1";
      foldlevelstart = 99;
      foldenable = true;
      spelllang = "en_uk";
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
      luasnip = {
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
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
          preselect = "cmp.PreselectMode.None";
          sources = [
            {name = "nvim_lsp";}
            {name = "path";}
            {name = "buffer";}
            {name = "luasnip";}
          ];
          mapping = {
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.close()";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<CR>" = "cmp.mapping.confirm({ select = false })";
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
          nil_ls = {
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
