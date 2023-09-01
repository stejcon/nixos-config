{ osConfig, ... }:

{
  xdg.configFile.hypr = {
    source = ./config;
    recursive = true;
  };

  xdg.configFile.hypr."background.webp" = if osConfig.networking.hostName == "thor" then {
    source = ./loki-background.webp;
    recursive = false;
  }
  else { # If not on a laptop default to 1920x1080 image
    source = ./thor-background.webp;
    recursive = false;
  };
}
