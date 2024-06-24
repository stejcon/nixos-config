{pkgs, ...}: {
  programs.nixvim = {
    extraConfigLua = ''
      require("telescope").load_extension("lazygit")
    '';
    extraPlugins = with pkgs.vimPlugins; [
      lazygit-nvim
    ];
    plugins = {
      gitsigns = {
        enable = true;
        settings = {
          current_line_blame = true;
          trouble = true;
        };
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>gg";
        action = "<cmd>LazyGit<CR>";
      }
    ];
  };
}
