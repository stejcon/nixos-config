{ config, pkgs, lib, ... }: {
  programs.git = {
    enable = true;
    userName = "Stephen Condon";
    userEmail = "stephen.condon2@gmail.com";
    lfs.enable = true;
  };
}
