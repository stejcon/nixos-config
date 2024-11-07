{
  pkgs,
  inputs,
  ...
}: let
  # TODO: This is temporary. Every machine should define their own monitors and wallpapers.
  customMonitors = [
    {
      name = "DP-1";
      width = 1920;
      height = 1080;
      refreshRate = 165;
      x = 0;
      y = 0;
    }
    {
      name = "HDMI-A-1";
      width = 1920;
      height = 1080;
      refreshRate = 165;
      x = 1920;
      y = 0;
    }
    {
      name = "eDP-1";
      width = 2256;
      height = 1504;
      refreshRate = 60;
      x = 0;
      y = 0;
    }
  ];
in {
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    systemd.enable = true;
    xwayland.enable = true;
    plugins = [inputs.hyprsplit.packages.${pkgs.system}.hyprsplit];

    settings = {
      plugin = {
        hyprsplit = {
          num_workspaces = 5;
        };
      };

      general = {
        layout = "master";
        resize_on_border = true;
      };

      monitor =
        map (
          m: let
            resolution = "${toString m.width}x${toString m.height}@${toString m.refreshRate}";
            position = "${toString m.x}x${toString m.y}";
          in "${m.name},${resolution},${position},1"
        )
        customMonitors;

      input = {
        kb_layout = "us";
        numlock_by_default = true;
        follow_mouse = 2;
        touchpad = {
          natural_scroll = true;
        };
        repeat_rate = 40;
        repeat_delay = 250;
        force_no_accel = true;
        sensitivity = 0;
      };

      misc = {
        disable_splash_rendering = true;
        disable_hyprland_logo = true;
        force_default_wallpaper = 1;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
        animate_manual_resizes = true;
        animate_mouse_windowdragging = true;
        enable_swallow = true;
        swallow_regex = "^(kitty)$";
      };

      decoration = {
        rounding = 5;
        blur = {
          enabled = true;
          size = 8;
          passes = 1;
        };
        shadow = {
          enabled = false;
          color = "rgba(1a1a1aee)";
          range = 30;
          render_power = 3;
        };
      };

      animations = {
        enabled = true;

        bezier = "myBezier, 0.25, 0.9, 0.1, 1.02";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        mfact = 0.6;
        new_status = "slave";
        orientation = "center";
        inherit_fullscreen = true;
      };

      gestures = {
        workspace_swipe = true;
      };

      "$mainMod" = "SUPER";

      bind =
        [
          "$mainMod      , return, exec, ${pkgs.kitty}/bin/kitty --title Kitty"
          "$mainMod      , b, exec, ${pkgs.firefox}/bin/firefox"
          "$mainMod      , q, killactive,"
          "$mainMod SHIFT, q, exit,"
          "$mainMod      , e, exec, ${pkgs.kitty}/bin/kitty -e ${pkgs.lf}/bin/lf"
          "$mainMod      , v, togglefloating,"
          "$mainMod      , p, exec, ${pkgs.wofi}/bin/wofi --show drun"
          "$mainMod SHIFT, s, exec, ${pkgs.grimblast}/bin/grimblast --notify copysave area"
          "$mainMod      , f, fullscreen"

          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"

          "$mainMod, h, movefocus, l"
          "$mainMod, l, movefocus, r"
          "$mainMod, k, movefocus, u"
          "$mainMod, j, movefocus, d"

          "$mainMod SHIFT, j, split:swapactiveworkspaces, current +1"
          "$mainMod SHIFT, k, split:swapactiveworkspaces, current -1"

          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"
        ]
        ++ map (n: "$mainMod SHIFT, ${toString n}, split:movetoworkspace, ${toString (
          if n == 0
          then 10
          else n
        )}") [1 2 3 4 5]
        ++ map (n: "$mainMod, ${toString n}, split:workspace, ${toString (
          if n == 0
          then 10
          else n
        )}") [1 2 3 4 5];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      exec-once = [
        "ags -b hypr"
        "hyprctl setcursor Qogir 24"
        "fragments"
      ];
    };
  };

  home.packages = with pkgs; [
    grim
    slurp
    wl-clipboard
    swww
    networkmanagerapplet
    wofi
    libnotify
    grimblast
  ];
}
