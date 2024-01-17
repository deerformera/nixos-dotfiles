# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  security.pam.services.rin.enableKwallet = true;

  boot.loader = {
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
    }; 
    # systemd-boot.enable = true;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
  };

  networking.hostName = "nixue";
  networking.networkmanager.enable = true;
  networking.firewall.allowedTCPPorts = [ 80 443];

  time.timeZone = "Asia/Jakarta";

  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver = {
    enable = true;
    layout = "us";
    displayManager.sddm.enable = true;
    displayManager.autoLogin.enable = true;
    displayManager.autoLogin.user = "rin";
    desktopManager.plasma5.enable = true;
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  users.users.rin = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  fonts.packages = with pkgs; [
    fira-code
  ];

  environment.systemPackages = with pkgs; [
    # sys
    neofetch
    neovim
    pfetch
    wget
    git
    aircrack-ng
    crunch
    wirelesstools
    openssl
    osslsigncode

    # apps
    gimp
    inkscape
    steam-run
    blender
    firefox
    gh
    yt-dlp
    vlc
    obs-studio
    kdenlive
    audacity
    latte-dock
    vscode.fhs
    google-chrome
    wineWowPackages.stable
  ];

  programs.steam.enable = true;
  services.httpd = {
    enable = true;
    adminAddr = "webmaster@example.org";
    virtualHosts."localhost" = {
      documentRoot = "/srv/www";
    };
  };

  environment.shellAliases = {
    nixos-switch = "sudo nixos-rebuild switch";
    nixos-cf = "sudo nvim /etc/nixos/configuration.nix";
  };

  system.stateVersion = "23.11"; # Did you read the comment?
}

