{pkgs, ...}: {
  imports = [
    ./barbar.nix
    ./comment.nix
    ./floaterm.nix
    ./lsp.nix
    ./lualine.nix
    ./neorg.nix
    ./oil.nix
    ./telescope.nix
    ./treesitter.nix
    ./which-key.nix
    ./git.nix
    ./trouble.nix
    ./notify.nix
    ./neorg.nix
    ./fidget.nix
    ./efm.nix
    ./typst.nix
    ./noneckpain.nix
  ];

  programs.nixvim = {
    # Configless extra plugins
    extraPlugins = with pkgs.vimPlugins; [
      nvim-web-devicons
    ];
  };
}
