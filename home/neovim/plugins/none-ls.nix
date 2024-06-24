{
  programs.nixvim.plugins.none-ls = {
    enable = true;
    sources = {
      code_actions = {
        statix = {
          enable = true;
        };
      };
      diagnostics = {
        ltrs = {
          enable = true;
        };
        statix = {
          enable = true;
        };
      };
      formatting = {
        alejandra = {
          enable = true;
        };
      };
    };
  };
}
