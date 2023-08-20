{ config, pkgs, lib, ... }:

{
  xdg.configFile.hypr = {
    source = ./config;
    recursive = true;
  };
}
