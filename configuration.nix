{ machine, pkgs, ... }:

{
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

  networking.hostName = "nixos";
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  time.timeZone = "Europe/Dublin";

  i18n.defaultLocale = "en_IE.UTF-8";

  services = {
    flatpak.enable = true;
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
  };

  programs.hyprland.enable = true;

  # services.printing.enable = true;

  users.users.stephen = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "lp" "scanner" ];
    initialPassword = "password";
  };

  environment.systemPackages = with pkgs; [
    librespot
    neovim
    wget
    firefox
    git
    xclip
    texlive.combined.scheme-full
    btop
    ncdu
    fzf
    glow
    wl-clipboard
  ];

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
  ];

  system.stateVersion = "22.11"; # Did you read the comment?

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

}
