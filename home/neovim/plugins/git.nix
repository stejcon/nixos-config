{pkgs, ...}: {
  extraPlugins = with pkgs.vimPlugins; [
    lazygit-nvim
  ];

  programs.nixvim = {
    extraConfigLua = ''
        require("telescope").load_extension("lazygit")
    '';
    plugins = {
      neogit = {
        enable = true;
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>gg";
        action = "<cmd>Lazygit<CR>";
      }
    ];
  };
}
