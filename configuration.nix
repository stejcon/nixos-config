{pkgs, nixpkgs, ...}: {
  nixpkgs.config.allowUnfree = true;

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
      displayManager.gdm.enable = true;
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

  programs.hyprland.enable = true;
  programs.dconf = {
    enable = true;
  };

  users.users.stephen = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "video" "audio" "lp" "scanner" "libvirtd"];
    initialPassword = "password";
  };

  environment.systemPackages = with pkgs; [
    neovim
    wget
    firefox
    git
    texlive.combined.scheme-full
    btop
    ncdu
    fzf
    glow
    wl-clipboard
    wofi
    swww
    networkmanagerapplet
    zathura
    pulsemixer
    virt-manager
    gamemode
    mangohud
  ];

  programs.direnv = {
    enable = true;
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
  ];

  fonts.packages = with pkgs; [
    liberation_ttf_v1
    helvetica-neue-lt-std
    (nerdfonts.override {fonts = ["FiraCode" "JetBrainsMono"];})
  ];

  security = {
    sudo.wheelNeedsPassword = false;
    doas.wheelNeedsPassword = false;
    polkit.enable = true;
  };

  system.stateVersion = "22.11"; # Did you read the comment?

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
    registry.nixpkgs.flake = nixpkgs;
  };
}
