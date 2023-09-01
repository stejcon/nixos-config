{
  config,
  pkgs,
  lib,
  ...
}: {
  services.picom = {
    enable = true;
    backend = "glx";
    fade = true;
    fadeSteps = [3.0e-2 3.0e-2];
    settings = {
      animations = true;
      animation-stiffness = 300.0;
      animation-dampening = 35.0;
      animation-clamping = false;
      animation-mass = 1;
      animation-for-open-window = "zoom";
      animation-for-menu-window = "slide-down";
      animation-for-transient-window = "slide-down";
      corner-radius = 8;
      rounded-corners-exclude = ["window_type = 'dock'" "window_type = 'desktop'"];
    };
  };
}
