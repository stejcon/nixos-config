{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  python-debug = pkgs.python3.withPackages (p: with p; [debugpy]);
  oh-lucy-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "oh-lucy-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "Yazeed1s";
      repo = "oh-lucy.nvim";
      rev = "706c74fe8dcc2014dc17bbc861a05d27623e06e3";
      sha256 = "sha256-DY40tabglFYGXB2NwCpTM5QHUt+uoO8Ti6XBfN3ocAU=";
    };
  };
in {
  imports = [./nixvim.nix]
  # programs.neovim = {
  #   enable = true;
  #   viAlias = true;
  #   vimAlias = true;
  #   vimdiffAlias = true;
  #   defaultEditor = true;

  #   plugins = with pkgs.vimPlugins; [
  #     plenary-nvim # Config

  #     # Colorschemes
  #     gruvbox-community
  #     everforest
  #     oxocarbon-nvim
  #     nightfox-nvim
  #     onedark-nvim
  #     kanagawa-nvim
  #     oh-lucy-nvim

  #     # Telescope/Treesitter
  #     telescope-nvim
  #     dressing-nvim # Config
  #     telescope-fzf-native-nvim
  #     nvim-treesitter.withAllGrammars

  #     # LSP
  #     nvim-lspconfig
  #     null-ls-nvim
  #     fidget-nvim
  #     nvim-lightbulb
  #     nvim-lsp-ts-utils

  #     # Completion
  #     luasnip
  #     nvim-cmp
  #     cmp-nvim-lsp
  #     cmp-buffer
  #     cmp-path
  #     cmp-cmdline
  #     cmp-nvim-lsp-signature-help
  #     cmp_luasnip
  #     lspkind-nvim

  #     # DAP
  #     nvim-dap
  #     telescope-dap-nvim
  #     nvim-dap-ui
  #     nvim-dap-virtual-text

  #     # Keys
  #     legendary-nvim
  #     which-key-nvim

  #     # Misc
  #     vimtex
  #     oil-nvim
  #     neorg
  #     lualine-nvim
  #     nvim-web-devicons
  #     gitsigns-nvim
  #     vim-illuminate
  #     nvim-notify
  #     no-neck-pain-nvim
  #   ];

  #   extraPackages = with pkgs; [
  #     tree-sitter
  #     nodejs
  #     ripgrep
  #     fd

  #     # Language Servers
  #     nil
  #     nixpkgs-fmt
  #     statix # Nix
  #     clang-tools_16 # Clangd and other clang stuff
  #     pyright
  #     black
  #     python-debug # Python
  #     rust-analyzer
  #     rustfmt # Rust
  #     lua-language-server # Lua
  #     java-language-server
  #     kotlin-language-server # Java/Kotlin
  #     nodePackages.typescript-language-server
  #     nodePackages.vscode-langservers-extracted # Webdev
  #     haskell-language-server # Haskell
  #   ];

  #   extraConfig = ''
  #     let g:python_debug_home = "${python-debug}"
  #     :luafile ~/.config/nvim/lua/init.lua
  #   '';
  # };

  # xdg.configFile.nvim = {
  #   source = ./config;
  #   recursive = true;
  # };
}
