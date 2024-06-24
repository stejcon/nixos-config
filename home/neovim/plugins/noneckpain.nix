{pkgs, ...}: {
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      no-neck-pain-nvim
    ];

    keymaps = [
      {
        key = "<leader>n";
        action = ":NoNeckPain<CR>";
        options.silent = true;
      }
    ];
  };
}
