{pkgs, ...}: {
  imports = [
    ./barbar.nix
    ./floaterm.nix
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
    ./noneckpain.nix
    ./lsp
  ];

  programs.nixvim = {
    # Configless extra plugins
    extraPlugins = with pkgs.vimPlugins; [
      nvim-web-devicons
    ];
  };
}
