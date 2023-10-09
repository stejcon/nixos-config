{
  osConfig,
  pkgs,
  ...
}: {
  wayland.windowManager = {
    hyprland.enable = true;
    hyprland.enableNvidiaPatches =
      if osConfig.networking.hostName == "thor"
      then true
      else false; # TODO: Change this so it can check if the host has nvidia hardware without hardcoding the host name
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
        col.active_border = "rgba(00ffffee)";
        #col.inactive_border = "rgba(595959aa)";
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
        col.shadow = "rgba(1a1a1aee)";
        inactive_opacity = 0.8;
      };

      animations = {
        enabled = true;

        bezier = ["wind, 0.05, 0.9, 0.1, 1.05" "winIn, 0.1, 1.1, 0.1, 1.1" "winOut, 0.3, -0.3, 0, 1 liner, 1, 1, 1, 1"];

        animation = ["windows, 1, 6, wind, slide" "windowsIn, 1, 6, winIn, slide" "windowsOut, 1, 5, winOut, slide" "windowsOut, 1, 5, winOut, slide" "border, 1, 1, liner" "borderangle, 1, 30, liner, loop" "fade, 1, 10, default" "workspaces, 1, 5, wind"];
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

      bind = ["$mainMod, Return, exec, kitty" "$mainMod, Q, killactive, " "$mainMod_SHIFT, Q, exit, " "$mainMod, E, exec, dolphin" "$mainMod, V, togglefloating, " "$mainMod, P, exec, wofi --show drun" "$mainMod, R, pseudo," "$mainMod, J, togglesplit," "$mainMod, F, fullscreen" "$mainMod, B, exec, firefox" "$mainMod, left, movefocus, l" "$mainMod, right, movefocus, r" "$mainMod, up, movefocus, u" "$mainMod, down, movefocus, d" "$mainMod, h, movefocus, l" "$mainMod, l, movefocus, r" "$mainMod, k, movefocus, u" "$mainMod, j, movefocus, d" "$mainMod, 1, workspace, 1" "$mainMod, 2, workspace, 2" "$mainMod, 3, workspace, 3" "$mainMod, 4, workspace, 4" "$mainMod, 5, workspace, 5" "$mainMod, 6, workspace, 6" "$mainMod, 7, workspace, 7" "$mainMod, 8, workspace, 8" "$mainMod, 9, workspace, 9" "$mainMod, 0, workspace, 10" "$mainMod SHIFT, 1, movetoworkspace, 1" "$mainMod SHIFT, 2, movetoworkspace, 2" "$mainMod SHIFT, 3, movetoworkspace, 3" "$mainMod SHIFT, 4, movetoworkspace, 4" "$mainMod SHIFT, 5, movetoworkspace, 5" "$mainMod SHIFT, 6, movetoworkspace, 6" "$mainMod SHIFT, 7, movetoworkspace, 7" "$mainMod SHIFT, 8, movetoworkspace, 8" "$mainMod SHIFT, 9, movetoworkspace, 9" "$mainMod SHIFT, 0, movetoworkspace, 10" "$mainMod, mouse_down, workspace, e+1" "$mainMod, mouse_up, workspace, e-1"];
      bindm = ["$mainMod, mouse:272, movewindow" "$mainMod, mouse:273, resizewindow"];
    };
  };

  # TODO: After using hyprland.settings, try and find a good way to autoscale to any monitor, alternatively, use AI to generate a new wallpaper every boot?
  xdg.configFile."hypr/background.webp".source =
    if osConfig.networking.hostName == "loki"
    then ./loki-background.webp
    else ./thor-background.webp;

  programs.waybar = {
    enable = true;
    settings = [
      {
        position = "top";
        layer = "top";
        height = 18;
        margin-top = 0;
        margin-bottom = 0;
        margin-left = 0;
        margin-right = 0;
        modules-left = ["wlr/workspaces"];
        modules-center = ["clock"];
        modules-right =
          ["backlight" "tray" "cpu" "memory" "disk" "wireplumber"]
          ++ (
            if osConfig.networking.hostName == "loki"
            then ["battery"]
            else []
          )
          ++ ["network"];
        clock = {
          format = " {:%H:%M}";
          tooltip = "true";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = " {:%d/%m}";
        };
        "wlr/workspaces" = {
          active-only = false;
          all-outputs = true;
          disable-scroll = false;
          on-scroll-up = "hyprctl dispatch workspace -1";
          on-scroll-down = "hyprctl dispatch workspace +1";
          format = "{icon}";
          on-click = "activate";
          format-icons = {
            urgent = "";
            active = "";
            default = "󰧞";
            sort-by-number = true;
          };
        };
        # TODO: Setup playerctl
        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{icon}  {capacity}%";
          format-charging = "{capacity}% 󰂄";
          format-plugged = "{capacity}% ";
          format-alt = "{icon} {time}";
          format-icons = ["" "" "" "" ""];
        };
        memory = {
          format = "󰍛 {}%";
          format-alt = "󰍛 {used}/{total} GiB";
          interval = 5;
        };
        cpu = {
          format = "󰻠 {usage}%";
          format-alt = "󰻠 {avg_frequency} GHz";
          interval = 5;
        };
        disk = {
          format = "󰋊 {percentage_used}%";
          format-alt = "󰋊 {used}/{total} GiB";
          interval = 5;
          path = "/";
        };
        network = {
          format-wifi = "󰤨";
          format-ethernet = "{ifname}";
          format-linked = "{ifname} (No IP)";
          format-disconnected = "󰤭";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
          tooltip-format = "{essid}";
          on-click-right = "nm-connection-editor";
        };
        tray = {
          icon-size = 16;
          spacing = 5;
        };
        backlight = {
          format = "{icon} {percent}%";
          format-icons = ["" "" "" "" "" "" "" "" ""];
          scroll-step = 0.2;
        };
        wireplumber = {
          format = " {volume}%";
          format-muted = "󰝟";
          scroll-step = 1;
          max-volume = 150;
        };
        # TODO: Screenshot item
        # TODO: Recorder item
      }
    ];
    style = ''
      * {
          border: none;
          border-radius: 0px;
          /*font-family: VictorMono, Iosevka Nerd Font, Noto Sans CJK;*/
          font-family: Iosevka, FontAwesome, Noto Sans CJK;
          font-size: 14px;
          font-style: normal;
          min-height: 0;
      }

      window#waybar {
          background: rgba(30, 30, 46, 0.5);
          border-bottom: 1px solid #282828;
          color: #f4d9e1
      }

      #workspaces {
      	background: #282828;
      	margin: 5px 5px 5px 5px;
        padding: 0px 5px 0px 5px;
      	border-radius: 16px;
        border: solid 0px #f4d9e1;
        font-weight: normal;
        font-style: normal;
      }
      #workspaces button {
          padding: 0px 5px;
          border-radius: 16px;
          color: #928374;
      }

      #workspaces button.active {
          color: #f4d9e1;
          background-color: transparent;
          border-radius: 16px;
      }

      #workspaces button:hover {
      	background-color: #E6B9C6;
      	color: black;
      	border-radius: 16px;
      }

      #custom-date {
      	color: #D3869B;
      }

      #custom-power {
      	color: #24283b;
      	background-color: #db4b4b;
      	border-radius: 5px;
      	margin-right: 10px;
      	margin-top: 5px;
      	margin-bottom: 5px;
      	margin-left: 0px;
      	padding: 5px 10px;
      }

      #tray {
          background: #282828;
          margin: 5px 5px 5px 5px;
          border-radius: 16px;
          padding: 0px 5px;
          /*border-right: solid 1px #282738;*/
      }

      #clock {
          background-color: #282828;
          /*color: #8EC07C;*/
          border-radius: 16px;
          margin: 5px;
          margin-left: 5px;
          margin-right: 5px;
          padding: 0px 10px 0px 10px;
          font-weight: bold;
      }

      #battery.charging {
          color: #9ece6a;
      }

      #battery.warning:not(.charging) {
          background-color: #f7768e;
          color: #24283b;
          border-radius: 5px 5px 5px 5px;
      }

      #network {
          color: #f4d9e1;
          border-radius: 8px;
          margin-right: 5px;
      }

      #pulseaudio {
          color: #f4d9e1;
          border-radius: 8px;
          margin-left: 0px;
      }

      #pulseaudio.muted {
          background: transparent;
          color: #928374;
          border-radius: 8px;
          margin-left: 0px;
      }

      #custom-randwall {
          color: #f4d9e1;
          border-radius: 8px;
          margin-right: 0px;
      }

      #custom-launcher {
          color: #e5809e;
          background-color: #282828;
          border-radius: 0px 24px 0px 0px;
          margin: 0px 0px 0px 0px;
          padding: 0 20px 0 13px;
          /*border-right: solid 1px #282738;*/
          font-size: 20px;
      }

      #custom-launcher button:hover {
          background-color: #FB4934;
          color: transparent;
          border-radius: 8px;
          margin-right: -5px;
          margin-left: 10px;
      }

      #custom-playerctl {
      	background: #282828;
      	padding-left: 15px;
        padding-right: 14px;
      	border-radius: 16px;
        /*border-left: solid 1px #282738;*/
        /*border-right: solid 1px #282738;*/
        margin-top: 5px;
        margin-bottom: 5px;
        margin-left: 0px;
        font-weight: normal;
        font-style: normal;
        font-size: 16px;
      }

      #custom-playerlabel {
          background: transparent;
          padding-left: 10px;
          padding-right: 15px;
          border-radius: 16px;
          /*border-left: solid 1px #282738;*/
          /*border-right: solid 1px #282738;*/
          margin-top: 5px;
          margin-bottom: 5px;
          font-weight: normal;
          font-style: normal;
      }

      #window {
          background: #282828;
          padding-left: 15px;
          padding-right: 15px;
          border-radius: 16px;
          /*border-left: solid 1px #282738;*/
          /*border-right: solid 1px #282738;*/
          margin-top: 5px;
          margin-bottom: 5px;
          font-weight: normal;
          font-style: normal;
      }

      #custom-wf-recorder {
          padding: 0 20px;
          color: #e5809e;
          background-color: #1E1E2E;
      }

      #cpu {
          background-color: #282828;
          /*color: #FABD2D;*/
          border-radius: 16px;
          margin: 5px;
          margin-left: 5px;
          margin-right: 5px;
          padding: 0px 10px 0px 10px;
          font-weight: bold;
      }

      #memory {
          background-color: #282828;
          /*color: #83A598;*/
          border-radius: 16px;
          margin: 5px;
          margin-left: 5px;
          margin-right: 5px;
          padding: 0px 10px 0px 10px;
          font-weight: bold;
      }

      #backlight,
      #battery,
      #wireplumber,
      #disk {
          background-color: #282828;
          /*color: #8EC07C;*/
          border-radius: 16px;
          margin: 5px;
          margin-left: 5px;
          margin-right: 5px;
          padding: 0px 10px 0px 10px;
          font-weight: bold;
      }

      #custom-hyprpicker {
          background-color: #282828;
          /*color: #8EC07C;*/
          border-radius: 16px;
          margin: 5px;
          margin-left: 5px;
          margin-right: 5px;
          padding: 0px 11px 0px 9px;
          font-weight: bold;
      }
    '';
  };

  # TODO: Mako, for notifications. Remember to add to exec-once in hyprland conf
}
