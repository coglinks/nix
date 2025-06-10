{
  description = "A simple NixOS flake";

  inputs = rec {
    # NixOS official package source, using the nixos-24.11 branch here
    #nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";
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
      # optional, not necessary for the module
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #hyprland = {
    #  url = "github:hyprwm/Hyprland";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
  # The following hyprland source is the one recommended for hyprtasking
    hyprland = {
      url = "github:hyprwm/Hyprland/v0.48.0";
      #url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprtasking = {
      url = "github:raybbian/hyprtasking";
      inputs.hyprland.follows = "hyprland";
    };
    #hyprland-plugins = {
    #  url = "github:hyprwm/hyprland-plugins";
    #  inputs.hyprland.follows = "hyprland";
    #};
    xremap-flake.url = "github:xremap/nix-flake";
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
		inputs.nypkgs = {
			url = "github:yunfachi/nypkgs";
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
			nypkgs,
      ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
		ylib = nypkgs.lib.${system};
  in {
    packages.${system}. default = pkgs.stdenvNoCC.mkDerivation rec {
      name = "my-shell";
      src = ./.;

      nativeBuildInputs = [
        ags.packages.${system}.default
        pkgs.wrapGAppsHook
        pkgs.gobject-introspection
      ];

      buildInputs = with astal.packages.${system}; [
        astal3
        io
        # any other package
      ];

      installPhase = ''
        mkdir -p $out/bin
        ags bundle app.ts $out/bin/${name}
      '';
    };

    nixosConfigurations.loq = nixpkgs.lib.nixosSystem {
      system = system;
      modules = [
        ./configuration.nix
        inputs.xremap-flake.nixosModules.default
        inputs.home-manager.nixosModules.default
        inputs.sops-nix.nixosModules.sops
        inputs.nix-flatpak.nixosModules.nix-flatpak
        lanzaboote.nixosModules.lanzaboote
        {
          _module.args = {
            inherit inputs;
            inherit hyprland;
            inherit system;
            inherit lanzaboote;
						inherit ylib;
          };
        }
      ];
    };

    homeConfigurations.clinc = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
			inherit ylib;
			modules = [
				./modules/clinc/home.nix
				./modules/clinc/pkgs.nix
				({ ylib, ... }: {
					imports = ylib.umport {
						paths = [ ./modules/hm-global ];
						recursive = true;
					};
				})
			];
    };
  };
}
