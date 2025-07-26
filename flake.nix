{
  description = "A simple NixOS flake";

  inputs = rec {
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";
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
      url = "github:hyprwm/Hyprland/v0.49.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprtasking = {
      url = "github:raybbian/hyprtasking";
      inputs.hyprland.follows = "hyprland";
    };
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
