{pkgs, ...}: {
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    userName = "Stephen Condon";
    userEmail = "stephen.condon2@gmail.com";
    lfs.enable = true;
    delta.enable = true;
    aliases = {
      a = "add --patch";
      p = "pull";
      P = "push";
      s = "status";
      co = "checkout";
      cob = "checkout -b";
      com = "checkout master";
      lg = "log --graph --abbrev-commit --decorate --format=format:'%C(blue)%h%C(reset) - %C(green)(%ar)%C(reset) %s %C(italic)- %an%C(reset)%C(magenta bold)%d%C(reset)' --all";
      amend = "commit --amend --no-edit";
      c = "commit";
      ca = "commit -a";
      cam = "commit -a -m";
      cm = "commit -m";
      rb = "rebase";
      rba = "rebase --abort";
      rbc = "rebase --continue";
      rbi = "rebase --interactive";
      rbs = "rebase --skip";
      r = "reset HEAD";
      r1 = "reset HEAD^";
      r2 = "reset HEAD^^";
      rhard = "reset --hard";
      rhard1 = "reset HEAD^ --hard";
      rhard2 = "reset HEAD^^ --hard";
    };
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      core = {
        editor = "nvim";
      };
      push = {
        autoSetupRemote = true;
      };
    };
  };

  programs.lazygit = {
    enable = true;
    settings = {
      git = {
        paging = {
          colorArg = "never";
          pager = "${pkgs.delta}/bin/delta --dark --paging=never";
        };
      };
    };
  };

  home.packages = with pkgs; [
    gitflow
  ];

}
