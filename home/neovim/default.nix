{inputs, ...}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./settings.nix
    ./autocomplete.nix
    ./autocommands.nix
    ./colorscheme.nix
    ./keymaps.nix
    ./ftplugin.nix
    ./performance.nix
    ./plugins
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;

    luaLoader.enable = true;
  };
}
