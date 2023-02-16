# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    neovim
    pfetch
    wget
    kitty alacritty
    home-manager
    brave firefox
    gparted
    btop
    git
    wineWowPackages.stable
    winetricks
    lutris
    vscodium
    pciutils
    vlc
    unzip
  ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
		enable = true;
		version = 2;
		efiSupport = true;
		device = "nodev";
		useOSProber = true;
  };
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # security.sudo.wheelNeedsPassword = false;

  networking.hostName = "nixue";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  time.timeZone = "Asia/Jakarta";
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    # desktopManager.gnome.enable = true;
    desktopManager.xfce.enable = true;
    # videoDrivers = [ "amdgpu" ];
  };

  # services.httpd = {
  #   enable = true;
  #   enablePHP = true;
  # };

  # Configure keymap in X11
  services.xserver.layout = "us";
  # services.printing.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # services.xserver.libinput.enable = true;

  # Some programs need SUID wrappers, can be configured further or are started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  system.stateVersion = "22.11"; # Did you read the comment?

}

