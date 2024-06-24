{
  programs.nixvim.plugins.neorg = {
    enable = false;
    lazyLoading = true;
    modules = {
      "core.defaults" = {
        __empty = null;
      };
      "core.concealer" = {
        __empty = null;
      };
      "core.completion" = {
        config = {
          engine = "nvim-cmp";
        };
      };
      "core.summary" = {
        __empty = null;
      };
    };
  };
}
