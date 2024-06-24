{
  programs.nixvim.plugins.fidget = {
    enable = true;
    progress = {
      suppressOnInsert = true; # Suppress new messages while in insert mode
    };
  };
}
