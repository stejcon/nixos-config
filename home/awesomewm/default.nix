{
  config,
  pkgs,
  lib,
  ...
}: {
  xdg.configFile.awesome = {
    source = ./config;
    recursive = true;
  };
}
