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
            chainingHints.enable = true;
            closingBraceHints = {
              enable = true;
              minLines = 25;
            };
            closureCaptureHints.enable = true;
            closureStyle = "impl_fn";
            closureReturnTypeHints.enable = "always";
            discriminantHints.enable = "always";
            expressionAdjustmentHints = {
              enable = "always";
              hideOutsideUnsafe = false;
              mode = "prefix";
            };
            implicitDrops.enable = true;
            lifetimeElisionHints.enable = "always";
            parameterHints.enable = true;
            rangeExclusiveHints.enable = true;
            maxLength = 25;
            renderColons = true;
            typeHints = {
              enable = true;
              hideClosureInitilization = false;
              hideNamedConstructor = false;
            };
          };
        };
      };
    };
  };
}
