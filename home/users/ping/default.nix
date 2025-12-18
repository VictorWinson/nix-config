{ config, pkgs, inputs, ... }:
let
  username = "ping";
  homeDirectory = "/home/ping";
in {
  home.username = username;
  home.homeDirectory = homeDirectory;

  imports = [
    inputs.nixvim.homeModules.nixvim
    inputs.niri.homeModules.niri
    ./modules/packages.nix
    ./modules/shell.nix
    ./modules/neovim.nix
    ./modules/gui.nix
  ];

  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  services.syncthing.enable = true;

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
