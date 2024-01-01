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

  # Use the grub EFI boot loader.
  boot.loader = {
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
        PasswordAuthentication = true;
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
