{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.nixvim.homeManagerModules.nixvim];

  programs.nixvim = {
    enable = true;
    clipboard.providers.wl-copy.enable = true;

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
    ];

    plugins = {
      oil = {
        enable = true;
        columns.type = true;
        columns.icon = true;
        size = true;
        permissions = true;
        mtime = true;
        viewOptions = {
          showHidden = true;
        };
      };
    };
  };
}
