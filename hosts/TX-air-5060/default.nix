{ inputs, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./modules/system.nix
    ./modules/power.nix
    ./modules/audio.nix
    ./modules/desktop.nix
  ];

  networking.hostName = "TX-air-5060";
}
