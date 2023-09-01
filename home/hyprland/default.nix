{osConfig, ...}: {
  xdg.configFile.hypr = {
    source = ./config;
    recursive = true;
  };

  xdg.configFile."hypr/background.webp".source =
    if osConfig.networking.hostName == "thor"
    then ./loki-background.webp
    else ./thor-background.webp;
}
