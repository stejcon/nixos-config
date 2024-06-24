{
  programs.nixvim.keymaps = [
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
}
