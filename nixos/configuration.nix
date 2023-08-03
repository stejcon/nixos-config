{ config, lib, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
    };
  };

  networking.hostName = "nixos";
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  time.timeZone = "Europe/Dublin";

  i18n.defaultLocale = "en_IE.UTF-8";

  services = {
    flatpak.enable = true;
    xserver = {
      libinput.enable = true;
      enable = true;
      displayManager = {
        sddm.enable = true;
        defaultSession = "plasma";
      };
      desktopManager.plasma5.enable = true;
      windowManager.awesome.enable = true;
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
    gnome.gnome-keyring.enable = true;
    mpd = {
        enable = true;
        musicDirectory = "/home/stephen/music";
        extraConfig = ''
            audio_output {
                type "pipewire"
                name "PipeWire Output"
            }
        '';
        user = "stephen";
    };
  };

  systemd.services.mpd.environment = {
      XDG_RUNTIME_DIR = "/run/user/1000";
  };

  programs.hyprland.enable = true;
  programs.ssh.startAgent = true;

  security.pam.loginLimits = [{
    domain = "*";
    type = "soft";
    item = "nofile";
    value = "4096";
  }];

  # services.printing.enable = true;

  users.users.stephen = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "lp" "scanner" ];
    initialPassword = "password";
    openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCKHyioZ40QMVciPyUttWk9uatUysQ02rSdJ2EA2cbbEuQ4dGGszmJ/KGBbm6eLdSkTg9fyGvTfxtSDPK77kEYkxg1wadQpZIBBLUpLJplve0BbTuhH2K8jwwMzGb5t/FGS1gIc3Fq1k9Wyewp0E/5LRScBLmvOh7g0GjMjeNsULpCanJ8MMwlvYwEMAr+w6ZnlbkuCWPFbiavPyvPPrrsqFnrbgnwJ/6KrULYH9yJdxCLVptBXUqj5AbDcfHwmGnKCOhK4Q4knVCTIRTLKiqsSiTNc/no9IYOeNoQ4rkWnATUQvPBkQ2QTSi4Lqew0D2OYFe9Qa7lXhT0OEyVxZmsxdowJckpxmjvPPjxBpgBxNfniRLKf1LMqfC9rL14RzHDK7pEeaAR5dGLWPzTCdB1W8KerROJLI7+ao9hdZUCATJD5JA0oTpDoWnLwC4DiTWgNFOJgzzRet0JRduIOAfQ5c9L/GLQMRJC6kIR0MUZtgjMaq28cPji0+nKi48AvQlc= stephen@nixos"
    ];
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
