{
  programs.nixvim.plugins.none-ls = {
    enable = true;
    sources = {
      code_actions = {
        statix.enable = true;
      };
      diagnostics = {
        codespell.enable = true;
        cppcheck.enable = true;
        ltrs.enable = true;
        selene.enable = true;
        statix.enable = true;
      };
      formatting = {
        alejandra.enable = true;
        typstyle.enable = true;
        clang_format.enable = true;
        stylua.enable = true;
      };
    };
  };
}
