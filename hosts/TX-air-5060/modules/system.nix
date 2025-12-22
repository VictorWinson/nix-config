{ config, pkgs, lib, ... }:
{
  #nix.settings = {
  #  substituters = lib.mkAfter [
  #    "https://cache.flox.dev"
  #  ];
  #  trusted-public-keys = lib.mkAfter [
  #    "flox-cache-public-1:7F4OyH7ZCnFhcze3fJdfyXYLQw/aV7GEed86nQ7IsOs="
  #  ];
  #};

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #time.timeZone = "Pacific/Auckland";
  time.timeZone = "Asia/Shanghai";
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "zh_CN.UTF-8";
    LC_IDENTIFICATION = "zh_CN.UTF-8";
    LC_MEASUREMENT = "zh_CN.UTF-8";
    LC_MONETARY = "zh_CN.UTF-8";
    LC_NAME = "zh_CN.UTF-8";
    LC_NUMERIC = "zh_CN.UTF-8";
    LC_PAPER = "zh_CN.UTF-8";
    LC_TELEPHONE = "zh_CN.UTF-8";
    LC_TIME = "zh_CN.UTF-8";
  };

  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = false;
  #networking.networkmanager.settings = {
  #  "connection" = { };
  #  "device" = { "wifi.powersave" = 2; };
  #};

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.trusted-users = ["root" "@wheel"];
  nixpkgs.config.allowUnfree = true;

  users.defaultUserShell = pkgs.zsh;
  users.users.ping = {
    isNormalUser = true;
    description = "ping";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ ];
  };

  environment.systemPackages = with pkgs; [
    vim
    joshuto
    htop
    ripgrep
    fastfetch
    wget
    curl
    git
    lm_sensors
    xwayland-satellite
  ];

  environment.pathsToLink = [
    "/share/applications"
    "/share/xdg-desktop-portal"
  ];


  programs.zsh.enable = true;

  services.openssh.enable = true;

  system.stateVersion = "23.11";
}
