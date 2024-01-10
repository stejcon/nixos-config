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
        flavour = "mocha";
        showBufferEnd = true;
      };
    };

    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    options = {
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
        columns = {
          icon.enable = true;
          size.enable = true;
          mtime.enable = true;
          permissions.enable = true;
        };
        viewOptions = {
          showHidden = true;
        };
      };
      lsp = {
        enable = true;
        keymaps = {
          lspBuf = {
            K = "hover";
            gD = "references";
            gd = "definition";
            gi = "implementation";
            gt = {
              action = "type_definition";
              desc = "LSP: Type Definition";
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
            settings.formatting.command = ["${pkgs.alejandra}/bin/alejandra"];
            extraOptions.settings = {autoArchive = true;};
          };
          pyright.enable = true;
          typst-lsp.enable = true;
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
        action = ":noh<CR><ESC>";
        options.silent = true;
      }
      {
        key = "-";
        action = '':lua require("oil").open_float()<CR>'';
        mode = ["n"];
        options.desc = "Oil: Open Floation Window";
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
    ];

    extraPlugins = with pkgs.vimPlugins; [
      nvim-web-devicons
    ];
  };
}
