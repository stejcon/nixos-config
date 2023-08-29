{ machine, ... }:

{
  xdg.configFile.hypr = {
    source = ./config;
    recursive = true;
  };

  xdg.configFile.hypr."background.webp" = {
    source = 
      if machine == "laptop" then ./laptop-background.webp
      else if machine == "desktop" then ./desktop-background.webp
      else ./desktop-background.webp;
  };
}
