{
  description = "Ping's NixOS Flake";

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [
      "https://hyprland.cachix.org"
      "https://cache.nixos.org/"
    ];
    extra-substituters = [ "https://nix-community.cachix.org" ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            lib = nixpkgs.lib // { map = builtins.map; };
          };
          modules = [
            ./hosts/nixos
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.ping = import ./home/users/ping;
              home-manager.extraSpecialArgs = {
                inherit inputs;
                lib = nixpkgs.lib // { map = builtins.map; };
              };
            }
          ];
        };
      };
    };
}
