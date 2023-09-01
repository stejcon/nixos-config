{config, ...}: {
  xdg.configFile.hypr = {
    source = ./config;
    recursive = true;
  };

  xdg.configFile."hypr/background.webp".source =
    if config.networking.hostName == "loki"
    then ./loki-background.webp
    else ./thor-background.webp;
}
