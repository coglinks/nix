{
  description = "A simple NixOS flake";

  inputs = rec {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprtasking = {
      url = "github:raybbian/hyprtasking";
      inputs.hyprland.follows = "hyprland";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      # Optional but recommended to limit the size of your system closure.
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
      home-manager,
      hyprland,
      treefmt-nix,
      astal,
      ags,
      lanzaboote,
      ... }@inputs:
  let
    linux64-system = "x86_64-linux";
    linux64-pkgs = nixpkgs.legacyPackages.${linux64-system};
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
        inputs.home-manager.nixosModules.default
        inputs.sops-nix.nixosModules.sops
        inputs.nix-flatpak.nixosModules.nix-flatpak
        lanzaboote.nixosModules.lanzaboote
        {
          _module.args = {
            inherit inputs;
            inherit hyprland;
            system = linux64-system;
            inherit lanzaboote;
          };
        }
      ];
    };

    homeConfigurations.clinc = home-manager.lib.homeManagerConfiguration {
      pkgs = linux64-pkgs;
      modules = [
        ./modules/clinc/home.nix
        ./modules/clinc/pkgs.nix
      ];
    };
  };
}
