{
  description = "Nixos config flake";

  inputs = {
	  flake-compat.url = "github:edolstra/flake-compat";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    hyprtasking = {
      url = "github:raybbian/hyprtasking";
      inputs.hyprland.follows = "hyprland";
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

#    xremap-flake.url = "github:xremap/nix-flake";
  };

  outputs = {
    self,
    nixpkgs-unstable,
    nixpkgs-stable,
    nixpkgs,
    home-manager,
    hyprland,
    flake-compat,
    ...
    } @inputs: let
      system = "x86_64-linux";
      pkgs-stable = import nixpkgs-stable {
        inherit system;
        config = { allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
          "nvidia-x11"
          "nvidia-settings"
          "spotify"
          "nvidia-persistenced"
          ]; 
        };
      };
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config = { allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
            "vscode"
            "nvidia-x11"
            "nvidia-settings"
            "nvidia-persistenced"
            "google-chrome"
            "steam"
            "steam-unwrapped"
            "discord"
          ]; 
        };
      };
      
      pkgs = pkgs-unstable;

      # Import readOnlyPkgs to handle read-only pkgs configuration
      readOnlyPkgs = nixpkgs-unstable.nixosModules.readOnlyPkgs;
  
      # Import nixpkgs.lib to access lib functions like getName
      lib = nixpkgs-unstable.lib;
    in
    {
      # use "nixos", or your hostname as the name of the configuration
      # it's a better practice than "default" shown in the video
      nixosConfigurations.nix-loq = nixpkgs-unstable.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit pkgs-stable;
          inherit pkgs-unstable;
          inherit pkgs;
        };
        modules = [
          ./configuration.nix
          inputs.home-manager.nixosModules.default 
          ./configuration-unstable.nix
          ./hardware-configuration.nix
          ./lanzaboote.nix
          ./modules/global/docker.nix
          ./modules/global/main-user.nix
          ./modules/loq/pkgs-stable.nix
          ./modules/loq/pkgs-unstable.nix
          ./modules/global/ssh.nix
          ./modules/global/vm.nix
          ./modules/loq/backup.nix
          ./modules/loq/nvidia.nix
          ./modules/global/main-user.nix
        ];
      };
      homeConfigurations.win-loq = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
          ./modules/win-loq/home.nix 
          ./modules/win-loq/pkgs-unstable.nix
          ];
        extraSpecialArgs = {
          inherit inputs;
          inherit pkgs-unstable;
          inherit pkgs-stable;
          inherit pkgs;
        };
      };
    };
}
