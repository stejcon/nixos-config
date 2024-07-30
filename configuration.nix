{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users.stephen = {...}: {
      imports = [
        ./home
      ];
    };
  };

  boot = {
    # BBR is a more improved congestion control method
    kernelModules = ["tcp_bbr"];

    kernel = {
      sysctl = {
        "net.ipv4.tcp_congestion_control" = "bbr";

        # Increase TCP window sizes for high bandwidth WAN connections
        # Assumes 10 GBit/s over 200ms latency worst case
        "net.core.wmem_max" = 1073741824; # 1 GiB
        "net.core.rmem_max" = 1073741824; # 1 GiB
        "net.ipv4.tcp_rmem" = "4096 87380 1073741824"; # 1 GiB max
        "net.ipv4.tcp_wmem" = "4096 87380 1073741824";
      };
    }; # 1 GiB max

    # Use the grub EFI boot loader.
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
      };
    };
  };

  swapDevices = [
    {
      device = "/swapfile";
      size = 16 * 1024;
    }
  ];

  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.
  networking.firewall.enable = false;

  time.timeZone = "Europe/Dublin";

  i18n.defaultLocale = "en_IE.UTF-8";

  services = {
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --remember-user-session --user-menu --asterisks --sessions ${config.services.displayManager.sessionData.desktops}/share/wayland-sessions --xsessions ${config.services.displayManager.sessionData.desktops}/share/xsessions";
          user = "greeter";
        };
      };
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = true;
        X11Forwarding = true;
      };
    };
    flatpak.enable = true;
    blueman.enable = true;
    fprintd.enable = false;
    upower.enable = true;
    power-profiles-daemon.enable = true;
  };

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal"; # Without this errors will spam on screen

    # Without these bootlogs will spam on screen
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };

  users.users.stephen = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "video" "audio" "lp" "scanner"];
    initialPassword = "password";
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    neovim
    wget
    btop
    ncdu
    fzf
    zathura
    pulsemixer
    google-chrome
    mangohud
    protonup
    zulu
    modrinth-app
    spotify-player
  ];

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
  };

  programs = {
    hyprland = {enable = true;};
    dconf = {enable = true;};
    direnv = {enable = true;};
    firefox = {enable = true;};
    git = {
      enable = true;
      lfs.enable = true;
    };
    zsh = {enable = true;};
    steam = {
      enable = true;
      gamescopeSession = {enable = true;};
    };
    gamemode = {enable = true;};
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
    xdgOpenUsePortal = true;
  };

  fonts.packages = with pkgs; [
    liberation_ttf_v1
    helvetica-neue-lt-std
    (nerdfonts.override {fonts = ["FiraCode" "JetBrainsMono"];})
  ];

  security = {
    sudo.wheelNeedsPassword = false;
    doas.wheelNeedsPassword = false;
    polkit.enable = true;
    pam = {
      services.swaylock = {};
    };
  };

  system.stateVersion = "22.11"; # Did you read the comment?

  nix = {
    extraOptions = "experimental-features = nix-command flakes";
    registry.nixpkgs.flake = inputs.nixpkgs;
  };
}
