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
    treefmt-nix.url = "github:numtide/treefmt-nix";
    hyprland = {
      url = "github:hyprwm/Hyprland/v0.46.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ags = {
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      # optional, not necessary for the module
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprtasking = {
      url = "github:raybbian/hyprtasking";
      inputs.hyprland.follows = "hyprland";
    };
    #Hyprspace = {
    #  url = "github:KZDKM/Hyprspace";
    #  inputs.hyprland.follows = "hyprland";
    #};
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
  };

  outputs = {
      self,
      nixpkgs,
      home-manager,
      hyprland,
      treefmt-nix,
      ags,
      lanzaboote,
      ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    packages.${system}.default = ags.lib.bundle {
      inherit pkgs;
      src = ./.;
      name = "my-shell";
      entry = "app.ts";
      gtk4 = false;

      extraPackages = [
        # ags.packages.${system}.battery
        # pkgs.fzf
      ];
    };

    nixosConfigurations.loq = nixpkgs.lib.nixosSystem {
      system = system;
      modules = [
        ./configuration.nix
        inputs.xremap-flake.nixosModules.default
        inputs.home-manager.nixosModules.default
        inputs.sops-nix.nixosModules.sops
        lanzaboote.nixosModules.lanzaboote
        {
          _module.args = {
            inherit inputs;
          };
        }
      ];
    };

    homeConfigurations.clinc = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ./modules/clinc/home.nix
        ./modules/clinc/pkgs.nix
      ];
    };
  };
}
