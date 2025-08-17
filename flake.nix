{
  description = "A simple NixOS flake";

  nixConfig = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    always-allow-substitutes = true;
    substituters = [
      "https://cache.nixos.org"
      "https://hyprland.cachix.org"
    ];
    trusted-substituters = [
      "https://cache.nixos.org"
      "https://hyprland.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
    extra-substituters = [
      "https://yazi.cachix.org"
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
    ];
    extra-trusted-substituters = [
      "https://yazi.cachix.org"
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = rec {
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      # url = "github:hyprwm/Hyprland/v0.49.0";
    };
     # hyprtasking = {
     #   url = "github:raybbian/hyprtasking";
     #   inputs.hyprland.follows = "hyprland";
     # };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak = {
      url = "github:gmodena/nix-flatpak";
    };
    iwmenu = {
      url = "github:e-tho/iwmenu";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    bzmenu = {
      url = "github:e-tho/bzmenu";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    astal = {
      url = "github:aylur/astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ags = {
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
      self,
      nixpkgs,
      nixpkgs-stable,
      nixpkgs-unstable,
      home-manager,
      stylix,
      hyprland,
      treefmt-nix,
      astal,
      ags,
      lanzaboote,
      ... }@inputs:
  let
    linux64-system = "x86_64-linux";
    linux64-commonArgs = { system = linux64-system; config.allowUnfree = true; };
    linux64-pkgs = import nixpkgs linux64-commonArgs;
    linux64-pkgs-stable = import nixpkgs-stable linux64-commonArgs;
    linux64-pkgs-unstable = import nixpkgs-unstable linux64-commonArgs;
  in {
    packages.${linux64-system}.default = linux64-pkgs.stdenvNoCC.mkDerivation rec {
      name = "my-shell";
      src = ./.;

      nativeBuildInputs = [
        ags.packages.${linux64-system}.default
        linux64-pkgs.wrapGAppsHook
        linux64-pkgs.gobject-introspection
      ];

      buildInputs = with astal.packages.${linux64-system}; [
        astal3
        io
        # any other package
      ];

      installPhase = ''
        mkdir -p $out/bin
        ${ags.packages.${linux64-system}.default}/bin/ags bundle app.ts $out/bin/${name}
      '';
    };

    nixosConfigurations.loq = nixpkgs.lib.nixosSystem {
      system = linux64-system;
      modules = [
        ./configuration.nix
        stylix.nixosModules.stylix
        inputs.home-manager.nixosModules.default
        inputs.sops-nix.nixosModules.sops
        inputs.nix-flatpak.nixosModules.nix-flatpak
        lanzaboote.nixosModules.lanzaboote
        {
          _module.args = {
            inherit inputs;
            inherit hyprland;
            inherit stylix;
            pkgs-stable = linux64-pkgs-stable;
            pkgs-unstable = linux64-pkgs-unstable;
            system = linux64-system;
            inherit lanzaboote;
          };
        }
      ];
    };

    homeConfigurations.clinc = home-manager.lib.homeManagerConfiguration {
      system = linux64-system;
      pkgs = linux64-pkgs;
      modules = [
        ./modules/devices/clinc/home.nix
        ./modules/devices/clinc/pkgs.nix
      ];
    };
  };
}
