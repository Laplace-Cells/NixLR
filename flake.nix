{

	description = "Desc: ndrmljr Flakes";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    zen-browser.url = "github:MarceColl/zen-browser-flake";
    niri.url = "github:xvrqt/niri-flake";

	};

	outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  }: let 

  system = "x86_64-linux";
  ndrmljr = home-manager.lib.homeManagerConfiguration;
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;	
  };
  lib = nixpkgs.lib;

  in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;
        modules = [
          ./host/configuration.nix
        ];
      };
    };
    homeConfigurations = {
      ndrmljr = ndrmljr {
        inherit pkgs;
        modules = [
          ./host/home.nix
        ];
      };
    };
  };
}
