{
  pkgs,
  config,
  inputs,
  ...
}: let
  startScript = pkgs.writeShellScriptBin "start" ''
    ${pkgs.swww}/bin/swww init &
    ${pkgs.networkmanagerapplet}/bin/nm-applet --indicator &
    hyprctl setcursor Bibata-Modern-Ice 16 &

    systemctl --user import-environment PATH &
    systemctl --user restart xdg-desktop-portal.service &

    # wait a tiny bit for wallpaper
    sleep 1

    # TODO: Need to be able to change wallpaper
    ${pkgs.swww}/bin/swww img ${./a-wooded-landscape-the-path-on-the-dyke.jpg} &
  '';

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
      borderRadius = 5;
      defaultTimeout = 3000;
      width = 250;
      height = 100;
      font = "JetBrainsMono Nerd Font 10";
      backgroundColor = "#3c3c3c";
      borderColor = "#595959";
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    plugins = [inputs.split-monitor-workspaces.packages.${pkgs.system}.split-monitor-workspaces];

    settings = {
      plugin = {
        split-monitor-workspaces = {
          count = 5;
        };
      };

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(00ffffee)";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "master";
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
        drop_shadow = false;
        shadow_range = 30;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
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
        new_is_master = true;
        orientation = "master";
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

          "$mainMod SHIFT, j, split-changemonitor, next"
          "$mainMod SHIFT, k, split-changemonitor, prev"

          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"
        ]
        ++ map (n: "$mainMod SHIFT, ${toString n}, split-movetoworkspace, ${toString (
          if n == 0
          then 10
          else n
        )}") [1 2 3 4 5]
        ++ map (n: "$mainMod, ${toString n}, split-workspace, ${toString (
          if n == 0
          then 10
          else n
        )}") [1 2 3 4 5];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # league of legends fixes
      windowrulev2 = [
        "float,class:^(leagueclientux.exe)$,title:^(League of Legends)$"
        "tile,class:^(league of legends.exe)$,title:^(League of Legends (TM) Client)$ windowrule = size 1920 1080,^(league of legends.exe)$"
      ];

      windowrule = [
        "size 1600 900,^(leagueclientux.exe)$"
        "center,^(leagueclientux.exe)$"
        "center,^(league of legends.exe)$"
        "forceinput,^(league of legends.exe)$"
      ];

      exec-once = [
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "${pkgs.bash}/bin/bash ${startScript}/bin/start"
        "waybar"
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
