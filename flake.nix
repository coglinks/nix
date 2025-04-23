{
  description = "Nixos config flake";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-compat.url = "github:edolstra/flake-compat";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    
    treefmt-nix.url = "github:numtide/treefmt-nix";

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

    nix-flatpak.url = "github:gmodena/nix-flatpak"; # unstable branch. Use github:gmodena/nix-flatpak/?ref=<tag> to pin releases.

    #    xremap-flake.url = "github:xremap/nix-flake";
  };

  outputs =
    {
      self,
      nix-flatpak,
      nixpkgs-unstable,
      nixpkgs-stable,
      nixpkgs,
      home-manager,
      hyprland,
      flake-parts,
      treefmt-nix,
      systems,
      flake-compat,
      ...
    }@inputs:
  # https://flake.parts/module-arguments.html
  flake-parts.lib.mkFlake { inherit inputs; } (top@{ config, withSystem, moduleWithSystem, ... }: {
    imports = [
      # Optional: use external flake logic, e.g.
      # inputs.foo.flakeModules.default
    ];
    flake = 
      # Put your original flake attributes here.

    let
      system = "x86_64-linux";
      pkgs-stable = import nixpkgs-stable {
        inherit system;
        config = {
          allowUnfreePredicate =
            pkg:
            builtins.elem (lib.getName pkg) [
              "nvidia-x11"
              "reaper"
              "nvidia-settings"
              "veracrypt"
              "spotify"
              "terraform"
              "nvidia-persistenced"
            ];
        };
      };
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config = {
          allowUnfreePredicate =
            pkg:
            builtins.elem (lib.getName pkg) [
              "vscode"
              "reaper"
              "spotify"
              "veracrypt"
              "nvidia-x11"
              "nvidia-settings"
              "terraform"
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
      # Small tool to iterate over each systems
      eachSystem = f: nixpkgs.lib.genAttrs (import systems) (system: f nixpkgs.legacyPackages.${system});

      # Eval the treefmt modules from treefmt.nix
      treefmtEval = eachSystem (pkgs: treefmt-nix.lib.evalModule pkgs ./treefmt.nix);
    in
    {
      # for `nix fmt`
      formatter = eachSystem (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper);
      # for `nix flake check`
      checks = eachSystem (pkgs: {
        formatting = treefmtEval.${pkgs.system}.config.build.check self;
      });
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
          ./hardware-configuration.nix
          ./lanzaboote.nix
          ./modules/global/docker.nix
          ./modules/global/hardware.nix
          ./modules/global/main-user.nix
          ./modules/global/main-user.nix
          ./modules/global/ssh.nix
          ./modules/global/vm.nix
          ./modules/global/wine.nix
          ./modules/loq/backup.nix
          ./modules/loq/flatpak.nix
          ./modules/loq/nvidia.nix
          ./modules/loq/ollama.nix
          ./modules/loq/pkgs-stable.nix
          ./modules/loq/pkgs-unstable.nix
          inputs.home-manager.nixosModules.default
          nix-flatpak.nixosModules.nix-flatpak
        ];
      };
      homeConfigurations.clinc = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./modules/clinc/home.nix
          ./modules/clinc/pkgs-unstable.nix
        ];
        extraSpecialArgs = {
          inherit inputs;
          inherit pkgs-unstable;
          inherit pkgs-stable;
          inherit pkgs;
        };
      };
    };
    systems = [
      # systems for which you want to build the `perSystem` attributes
      "x86_64-linux"
      # ...
    ];
    perSystem = { config, pkgs, ... }: {
      # Recommended: move all package definitions here.
      # e.g. (assuming you have a nixpkgs input)
      # packages.foo = pkgs.callPackage ./foo/package.nix { };
      # packages.bar = pkgs.callPackage ./bar/package.nix {
      #   foo = config.packages.foo;
      # };
    };
  });
}
