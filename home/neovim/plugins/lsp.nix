{pkgs, config, ...}: {
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

  programs.nixvim.plugins = {

  lsp = {
    enable = true;

    keymaps = {
      silent = true;
      diagnostic = {
        # Navigate in diagnostics
        "<leader>k" = "goto_prev";
        "<leader>j" = "goto_next";
      };

      lspBuf = {
        gd = "definition";
        gD = "references";
        gt = "type_definition";
        gi = "implementation";
        K = "hover";
        "<F2>" = "rename";
        "<F3>" = "code_action";
        "<leader>fm" = "format";
      };
    };

    servers = {
      clangd.enable = true;
      lua-ls.enable = true;
      rust-analyzer = {
        enable = true;
        installRustc = false;
        installCargo = false;
      };
      nil-ls = {
        enable = true;
        extraOptions.settings.nil = {
          nix.flake.autoArchive = true;
        };
      };
      pylsp = {
        enable = true;
        settings.plugins = {
          autopep8.enabled = false;
          pycodestyle.enabled = false;
          pyflakes.enabled = false;
          yapf.enabled = false;
          black = {
            enabled = false;
          };
          flake8 = {
            enabled = false;
            maxLineLength = 88;
          };
        };
      };
    };

    efmls-configs = {
setup = {
nix = {
        formatter = "alejandra";
        linter = "statix";
};
        c.formatter = "clang_format";
        "c++".formatter = "clang_format";
        lua.formatter = "stylua";
python = {
        formatter = "black";
        linter = "flake8";
};
        rust.formatter = "rustfmt";
};
    };
};
  };
}
