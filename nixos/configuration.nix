{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/nvme0n1";
  boot.loader.grub.useOSProber = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  boot.loader.grub.enableCryptodisk=true;

  boot.initrd.luks.devices."luks-e7532995-11e9-4b23-b668-ab0aa1ea5fa4".keyFile = "/crypto_keyfile.bin";
  networking.hostName = "nixos"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  virtualisation.docker = {
    enable = true;
  };

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Needed to run Jetpack Compose...
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      libGL
    ];
    setLdLibraryPath = true;
  };

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cmikol = {
    isNormalUser = true;
    description = "Cody Mikol";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  programs.steam.enable = true;
  # programs.hyprland.enable = true;

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  # nixpkgs.config.allowUnfree = true;
  
  # nixpkgs.config.packageOverrides = pkgs: {
  #     unstable = import (fetchTarball { 
  #     url = "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
  #	sha256 = "1ds3yjcy52l8d3rkxr3b7h9c0c3nly079bgakjaasnfjj3xprrwr";
  #  }) {};
  #};

  #environment.systemPackages = with pkgs; [
     #unstable.neovim
     #vim
     #firefox
     #steam
     #tmux
     #curl
     #git
     #kitty
     #clang
     #zig
     #nodejs_22
     #unzip
     #coolercontrol.coolercontrol-gui
     #coolercontrol.coolercontrold
     #discord
     #virtualbox
     #nix-search-cli
     #wget
     #python3
     #lua-language-server
     #luarocks
     #lua5_1
     #lazygit
     #ripgrep
     #rustc
     #xclip
     #fd
     #tree-sitter
     #kotlin
     #temurin-bin
     #gradle
     #home-manager
     #google-cloud-sdk
     #jq
     #terraform-lsp
     #opentofu
     #docker
     #docker-compose
     #stylua
     #nil
     #kotlin-language-server
  #];

   virtualisation.virtualbox.host.enable = true;
   users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];

   networking.firewall.allowedTCPPorts = [ 8443 ];

  system.stateVersion = "24.05"; # Did you read the comment?

}
