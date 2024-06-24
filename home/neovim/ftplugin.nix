{
    programs.nixvim.files."after/ftplugin/nix.lua" = {
        localOpts = {
            tabstop = 2;
            shiftwidth = 2;
        };
    };
}
