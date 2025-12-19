{ inputs, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./modules/proxy.nix
    ./modules/system.nix
    ./modules/power.nix
    ./modules/audio.nix
    ./modules/desktop.nix
    ./modules/steam.nix
  ];

  networking.hostName = "TX-air-5060";
}
