{
  inputs,
  pkgs,
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
    kernel.sysctl."net.ipv4.tcp_congestion_control" = "bbr";

    # Increase TCP window sizes for high bandwidth WAN connections
    # Assumes 10 GBit/s over 200ms latency worst case
    kernel.sysctl."net.core.wmem_max" = 1073741824; # 1 GiB
    kernel.sysctl."net.core.rmem_max" = 1073741824; # 1 GiB
    kernel.sysctl."net.ipv4.tcp_rmem" = "4096 87380 1073741824"; # 1 GiB max
    kernel.sysctl."net.ipv4.tcp_wmem" = "4096 87380 1073741824"; # 1 GiB max

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

  virtualisation = {
    libvirtd = {
      enable = true;
    };
  };

  services = {
    xserver = {
      enable = true;
      desktopManager.plasma5.enable = true;
    };

    # TODO: Should use "--sessions" argument in tuigreet
    # Figure out how to correctly find the .desktop file for every enabled window manager/desktop
    # May require everything to be in modules first
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd Hyprland";
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
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        X11Forwarding = true;
      };
    };
    printing.enable = true;
    flatpak.enable = true;
    blueman.enable = true;
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
    extraGroups = ["wheel" "networkmanager" "video" "audio" "lp" "scanner" "libvirtd"];
    initialPassword = "password";
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCspsHlBLTJL4VHKRO1xuLbnG/fay9anQLB+mhQfoHW+zVtzQv3xCPatfxIyGeaSSpV2RBO3w/oRauLVT3jfAzwjVj4FmXSztfbcJQY2Fk9CKYb+JthBqLKggSyixr39LfGNVpf5nw8vZbsSJS3ASJHzAGLnBuX184IufJspEo7MRKXpCmun2ukZT8advYO1N1QeaUjmxApZ5vvPrchpMm/tgZThYrooSIDIKjl2871DKb5Zkdojb0L1+UZ5HktMVexunJ35ik3qWJyrLNjAaP1NM9Xtg42lIR/949HkdeiXAkTH6rViCow7TKC1kirHmBpbWf+H7NduMZByTSECdcLcyBb6GxYX26lb/VQyoltHjZjKhaF3aiJYKu1hV6GQpia3/+1DuzSM+qqAHMgLY3/VS08yDDvE130SlD0SYmLlcn/s0+A7e+QDmBUpwVjOoxpqAAesgs1mAOvA7FJCSEc8YAdt9PEYDzREeunOnd0hX7TWSZ7aWOg45lMfDn4pac= stephen"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCyZemxjkK8PEtCeC8XnwqhS0Zbcuz7NjXSFvqk/IgYNikcegb0Edb8KtD3DzxqDdlwin0g4BEqru8hh+gc/K/1l9Vz5ff2XbwEDpD2Ekcv9Wd/vLNurXN1uYjLchSWCRtMsunYpx8E1gf6Phgb0+dqYO8swG/h6p3UXG9wY7hDqKVCSNbHHHuZaCgyYASu+LbyU9NJhe97gsfFQRUYgNRHYB3Fl5N8ldnOI+HX4DHTcMHzAGEai22yNBkqTorQO0yZ/kVSSnjSCObj2kShMjNvEsouNMGp27ADo7x9DytCM7difPt+uNl5Z60QHzfKMd1VQwj/0Kkz+jIsR/h+7nBUj/zph3B5XKG8AAGuHkJn6t0EXjO7wqhIlQdallEre5QehWbnCcd8/xdlUPZ7qc/hCr5wI9k7jBV9aYG0PMYgKsl+XdWnvPo8+4aIFKL7zAYdjugdwUaAgOH/y36jBNS10Gn/r6TXNxgbxwyQVTra1BEY8pDCPLdPKvEByjrIGOk= stephen"
    ];
  };

  environment.systemPackages = with pkgs; [
    neovim
    wget
    texlive.combined.scheme-full
    btop
    ncdu
    fzf
    glow
    zathura
    pulsemixer
    virt-manager
    gamemode
    mangohud
    libreoffice
    python311
    python311Packages.pygments
  ];

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
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
    registry.nixpkgs.flake = inputs.nixpkgs;
  };
}
