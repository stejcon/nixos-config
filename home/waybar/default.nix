{pkgs, ...}: let
  scripts = import ./scripts.nix {inherit pkgs;};

  workspaces = {
    format = "{icon}";
    # TODO: If I break the sequence, waybar crashes, should be done with a map somehow
    format-icons = {
      "1" = "1";
      "2" = "2";
      "3" = "3";
      "4" = "4";
      "5" = "5";
      "6" = "1";
      "7" = "2";
      "8" = "3";
      "9" = "4";
      "10" = "5";
      "11" = "1";
      "12" = "2";
      "13" = "3";
      "14" = "4";
      "15" = "5";
      active = "";
      default = "";
      urgent = "";
    };
    persistent-workspaces = {
      "1" = ["DP-1" "eDP-1"];
      "2" = ["DP-1" "eDP-1"];
      "3" = ["DP-1" "eDP-1"];
      "4" = ["DP-1" "eDP-1"];
      "5" = ["DP-1" "eDP-1"];
      "11" = ["HDMI-A-1"];
      "12" = ["HDMI-A-1"];
      "13" = ["HDMI-A-1"];
      "14" = ["HDMI-A-1"];
      "15" = ["HDMI-A-1"];
    };
    on-click = "activate";
    all-outputs = false;
  };

  mainWaybarConfig = {
    mod = "dock";
    layer = "top";
    gtk-layer-shell = true;
    height = 14;
    position = "top";

    modules-left = ["custom/power" "hyprland/workspaces" "hyprland/window"];
    modules-center = ["clock"];
    modules-right = [
      "network"
      "bluetooth"
      "pulseaudio"
      "pulseaudio#microphone"
      "custom/battery"
      "tray"
    ];

    "wlr/workspaces" = workspaces;
    "hyprland/workspaces" = workspaces;

    bluetooth = {
      format = "";
      format-connected = " {num_connections}";
      format-disabled = "";
      tooltip-format = " {device_alias}";
      tooltip-format-connected = "{device_enumerate}";
      tooltip-format-enumerate-connected = " {device_alias}";
      on-click = "${pkgs.blueman}/bin/blueman-manager";
    };

    clock = {
      actions = {
        on-click-backward = "tz_down";
        on-click-forward = "tz_up";
        on-click-right = "mode";
        on-scroll-down = "shift_down";
        on-scroll-up = "shift_up";
      };
      calendar = {
        format = {
          days = "<span color='#ecc6d9'><b>{}</b></span>";
          months = "<span color='#ffead3'><b>{}</b></span>";
          today = "<span color='#ff6699'><b><u>{}</u></b></span>";
          weekdays = "<span color='#ffcc66'><b>{}</b></span>";
          weeks = "<span color='#99ffdd'><b>W{}</b></span>";
        };
        mode = "year";
        mode-mon-col = 3;
        on-click-right = "mode";
        on-scroll = 1;
        weeks-pos = "right";
      };
      format = "󰥔 {:%H:%M}";
      format-alt = "󰥔 {:%A, %B %d, %Y (%R)} ";
      tooltip-format = ''"<tt><small>{calendar}</small></tt>"'';
    };

    "custom/battery" = {
      exec = "${scripts.battery}/bin/script";
      format = " 󰁹 {}";
      interval = 10;
    };

    "custom/power" = {
      exec = "echo ' '";
      format = "{}";
      tooltip = false;
      on-click = "${pkgs.wlogout}/bin/wlogout --protocol layer-shell";
    };

    "hyprland/window" = {
      format = "  {}";
      rewrite = {
        "(.*) — Mozilla Firefox" = "Firefox 󰈹";
        "(.*)Steam" = "Steam 󰓓";
      };
      separate-outputs = true;
    };

    network = {
      format-disconnected = " Disconnected";
      format-ethernet = "󱘖 Wired";
      format-linked = "󱘖 {ifname} (No IP)";
      format-wifi = "󰤨 {essid}";
      interval = 5;
      max-length = 30;
      tooltip-format = "󱘖 {ipaddr}  {bandwidthUpBytes}  {bandwidthDownBytes}";
    };

    pulseaudio = {
      format = "{icon} {volume}%";
      format-icons = {
        car = " ";
        default = ["" "" ""];
        hands-free = " ";
        headphone = " ";
        headset = " ";
        phone = " ";
        portable = " ";
      };
      format-muted = "󰖁 {volume}%";
      on-click = "${pkgs.pavucontrol}/bin/pavucontrol --tab 3";
      on-click-middle = "${pkgs.pamixer}/bin/pamixer --toggle-mute";
      on-scroll-down = "${pkgs.pamixer}/bin/pamixer --decrease 5";
      on-scroll-up = "${pkgs.pamixer}/bin/pamixer --increase 5";
      scroll-step = 5;
      tooltip-format = "{icon} {desc} {volume}%";
    };

    "pulseaudio#microphone" = {
      format = "{format_source}";
      format-source = "  {volume}%";
      format-source-muted = "  {volume}%";
      on-click = "${pkgs.pavucontrol}/bin/pavucontrol --tab 4";
      on-click-middle = "${pkgs.pamixer}/bin/pamixer --default-source --toggle-mute";
      on-scroll-down = "${pkgs.pamixer}/bin/pamixer --default-source --decrease 5";
      on-scroll-up = "${pkgs.pamixer}/bin/pamixer --default-source --increase 5";
      scroll-step = 5;
    };

    tray = {
      icon-size = 15;
      spacing = 5;
    };
  };

  css = ''
    * {
        border: none;
        border-radius: 0px;
        font-family: "JetBrainsMono Nerd Font";
        font-weight: bold;
        font-size: 14px;
        min-height: 0px;
    }

    window#waybar {
    }

    tooltip {
        background: @theme_unfocused_base_color;
        color: @theme_text_color;
        border-radius: 10px;
        border-width: 1px;
        border-style: solid;
        border-color: shade(alpha(@theme_text_colors, 0.9), 1.25);
    }

    #workspaces button {
        box-shadow: none;
    	text-shadow: none;
        padding: 0px;
        border-radius: 7px;
        padding-right: 0px;
        padding-left: 4px;
        margin-right: 7px;
        margin-left: 7px;
        color: @theme_text_color;
        animation: gradient_f 2s ease-in infinite;
        transition: all 0.2s cubic-bezier(.55,-0.68,.48,1.682);
    }

    #workspaces button.active {
        color: @accent_color;
        animation: gradient_f 20s ease-in infinite;
        transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
    }

    #workspaces button:hover {
        color: @accent_color;
        animation: gradient_f 20s ease-in infinite;
        transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
    }

    #cpu,
    #memory,
    #custom-power,
    #clock,
    #workspaces,
    #window,
    #custom-updates,
    #network,
    #bluetooth,
    #pulseaudio,
    #custom-wallchange,
    #custom-mode,
    #tray {
        color: @theme_text_color;
        background: shade(alpha(@theme_text_colors, 0.9), 1.25);
        opacity: 1;
        padding: 0px;
        margin: 3px 3px 3px 3px;
    }

    #custom-battery {
        color: @green_1
    }

    /* resource monitor block */

    #cpu {
        border-radius: 10px 0px 0px 10px;
        margin-left: 25px;
        padding-left: 12px;
        padding-right: 4px;
    }

    #memory {
        border-radius: 0px 10px 10px 0px;
        border-left-width: 0px;
        padding-left: 4px;
        padding-right: 12px;
        margin-right: 6px;
    }


    /* date time block */
    #clock {
        color: @yellow_1;
        padding-left: 12px;
        padding-right: 12px;
    }


    /* workspace window block */
    #workspaces {
        border-radius: 9px 9px 9px 9px;
        background: mix(@theme_unfocused_base_color,white,0.1);
    }

    #window {
        /* border-radius: 0px 10px 10px 0px; */
        /* padding-right: 12px; */
    }


    /* control center block */
    #custom-updates {
        border-radius: 10px 0px 0px 10px;
        margin-left: 6px;
        padding-left: 12px;
        padding-right: 4px;
    }

    #network {
        color: @purple_1;
        padding-left: 4px;
        padding-right: 4px;
    }

    #language {
        color: @orange_1;
        padding-left: 9px;
        padding-right: 9px;
    }

    #bluetooth {
        color: @blue_1;
        padding-left: 4px;
        padding-right: 0px;
    }

    #pulseaudio {
        color: @purple_1;
        padding-left: 4px;
        padding-right: 4px;
    }

    #pulseaudio.microphone {
        color: @red_1;
        padding-left: 0px;
        padding-right: 4px;
    }


    /* system tray block */
    #custom-mode {
        border-radius: 10px 0px 0px 10px;
        margin-left: 6px;
        padding-left: 12px;
        padding-right: 4px;
    }

    #custom-power {
        margin-left: 6px;
        padding-right: 4px;
        color: @blue_1;
        font-size: 16px;

    }

    #tray {
        padding-left: 4px;
        padding-right: 4px;
    }
  '';
in {
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
    });
    style = css;
    settings = {mainBar = mainWaybarConfig;};
  };

  programs.wlogout = {
    enable = true;
  };

  home.packages = with pkgs; [
    pamixer
    pavucontrol
    blueman
  ];
}
