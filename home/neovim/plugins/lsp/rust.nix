{
  lib,
  pkgs,
  config,
  ...
}: {
  home = {
    packages = with pkgs; [
      bacon
      gcc
      rustc
      cargo
      rustfmt
    ];
    sessionVariables.CARGO_HOME = "${config.xdg.dataHome}/cargo";
  };

  programs.nixvim.plugins.rustaceanvim = {
    enable = true;
    settings = {
      server = {
        settings = {
          cargo = {
            features = "all";
          };

          diagnostics = {
            styleLints.enable = true;
          };

          checkOnSave = true;
          check = {
            command = "${lib.getExe pkgs.clippy}";
          };

          files = {
            excludeDirs = [
              ".cargo"
              ".direnv"
              ".git"
              "node_modules"
              "target"
            ];
          };

          inlayHints = {
            bindingModeHints.enable = true;
            closureCaptureHints = true;
            closureStyle = "rust_analyzer";
            closureReturnTypeHints.enable = "always";
            discriminantHints.enable = "always";
            expressionAdjustmentHints.enable = "always";
            implicitDrops.enable = true;
            lifetimeElisionHints.enable = "always";
            rangeExclusiveHints.enable = true;
          };
        };
      };
    };
  };
}
