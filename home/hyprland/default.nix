{
  osConfig,
  pkgs,
  config,
  ...
}: {
  programs = {
    swaylock = {
      enable = true;
      package = pkgs.swaylock-effects;
      settings = {
        daemonize = true;
        screenshots = true;
        clock = true;
        indicator = true;
        indicator-radius = 120;
        indicator-thickness = 10;
        effect-blur = "7x10";
        effect-vignette = "0.5:0.5";
        text-color = "eeeeee";
        ring-color = "005678";
        key-hl-color = "ff2a6d";
        line-color = "00000000";
        inside-color = "00000088";
        separator-color = "00000000";
        fade-in = 1.0;
      };
    };
  };

  services = {
    # TODO: Add a timeout to suspend the computer
    swayidle = {
      enable = true;
      timeouts = [
        {
          timeout = 600;
          command = "${config.programs.swaylock.package}/bin/swaylock";
        }
        {
          timeout = 1800;
          command = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl dispatch dpms off";
          resumeCommand = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl dispatch dpms on";
        }
      ];
      events = [
        {
          event = "before-sleep";
          command = "${config.programs.swaylock.package}/bin/swaylock";
        }
      ];
      systemdTarget = "hyprland-session.target";
    };
    mako = {
      enable = true;
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;

    # TODO: Switch to using hyprland.settings instead of the xdg method below
    hyprland.settings = {
      monitor = ["DP-1,1920x1080@165,auto,1" "HDMI-A-1,1920x1080@60,auto,1" ",preferred,auto,1"];

      exec-once = ["waybar" "swww init" "swww img /home/stephen/.config/hypr/background.webp"];

      input = {
        kb_layout = "us";
        numlock_by_default = true;

        follow_mouse = 2;

        touchpad = {
          natural_scroll = true;
        };

        sensitivity = 0;
      };

      general = {
        gaps_in = 10;
        gaps_out = 20;
        border_size = 1;
        "col.active_border" = "rgba(00ffffee)";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
        cursor_inactive_timeout = 5;
      };

      decoration = {
        rounding = 5;
        blur = {
          enabled = true;
          size = 8;
          passes = 1;
        };
        drop_shadow = false;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
        inactive_opacity = 0.8;
      };

      animations = {
        enabled = true;

        bezier = [
          "smoothOut, 0.36, 0, 0.66, -0.56"
          "smoothIn, 0.25, 1, 0.5, 1"
          "overshot, 0.4,0.8,0.2,1.2"
        ];

        animation = [
          "windows, 1, 4, overshot, slide"
          "windowsOut, 1, 4, smoothOut, slide"
          "border,1,10,default"

          "fade, 1, 10, smoothIn"
          "fadeDim, 1, 10, smoothIn"
          "workspaces,1,4,overshot,slidevert"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_is_master = true;
      };

      gestures = {
        workspace_swipe = true;
      };

      misc = {
        disable_splash_rendering = true;
        disable_hyprland_logo = true;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
        animate_manual_resizes = true;
        animate_mouse_windowdragging = true;
        enable_swallow = true;
        swallow_regex = "^(kitty)$";
      };

      "$mainMod" = "SUPER";

      bind = ["$mainMod, Return, exec, kitty --title Kitty" "$mainMod, Q, killactive, " "$mainMod_SHIFT, Q, exit, " "$mainMod, E, exec, dolphin" "$mainMod, V, togglefloating, " "$mainMod, P, exec, wofi --show drun" "$mainMod, R, pseudo," "$mainMod, J, togglesplit," "$mainMod, F, fullscreen" "$mainMod, B, exec, firefox" "$mainMod, left, movefocus, l" "$mainMod, right, movefocus, r" "$mainMod, up, movefocus, u" "$mainMod, down, movefocus, d" "$mainMod, h, movefocus, l" "$mainMod, l, movefocus, r" "$mainMod, k, movefocus, u" "$mainMod, j, movefocus, d" "$mainMod, 1, workspace, 1" "$mainMod, 2, workspace, 2" "$mainMod, 3, workspace, 3" "$mainMod, 4, workspace, 4" "$mainMod, 5, workspace, 5" "$mainMod, 6, workspace, 6" "$mainMod, 7, workspace, 7" "$mainMod, 8, workspace, 8" "$mainMod, 9, workspace, 9" "$mainMod, 0, workspace, 10" "$mainMod SHIFT, 1, movetoworkspace, 1" "$mainMod SHIFT, 2, movetoworkspace, 2" "$mainMod SHIFT, 3, movetoworkspace, 3" "$mainMod SHIFT, 4, movetoworkspace, 4" "$mainMod SHIFT, 5, movetoworkspace, 5" "$mainMod SHIFT, 6, movetoworkspace, 6" "$mainMod SHIFT, 7, movetoworkspace, 7" "$mainMod SHIFT, 8, movetoworkspace, 8" "$mainMod SHIFT, 9, movetoworkspace, 9" "$mainMod SHIFT, 0, movetoworkspace, 10" "$mainMod, mouse_down, workspace, e+1" "$mainMod, mouse_up, workspace, e-1"];
      bindm = ["$mainMod, mouse:272, movewindow" "$mainMod, mouse:273, resizewindow"];
    };
  };

  # TODO: After using hyprland.settings, try and find a good way to autoscale to any monitor, alternatively, use AI to generate a new wallpaper every boot?
  xdg.configFile."hypr/background.webp".source =
    if osConfig.networking.hostName == "loki"
    then ./loki-background.webp
    else ./thor-background.webp;

  # TODO: Mako, for notifications. Remember to add to exec-once in hyprland conf
}
