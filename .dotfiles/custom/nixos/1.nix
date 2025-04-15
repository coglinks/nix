{
  description = "Unified NixOS and Home Manager configuration";

  inputs = {
    # Nixpkgs sources
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-24.11";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland-related inputs
    hyprland = {
      type = "git";
      url = "https://github.com/hyprwm/Hyprland";
      submodules = true;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprtasking = {
      url = "github:raybbian/hyprtasking";
      inputs.hyprland.follows = "hyprland";
    };
    Hyprspace = {
      url = "github:KZDKM/Hyprspace";
      inputs.hyprland.follows = "hyprland";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfreePredicate =
            pkg:
            builtins.elem (lib.getName pkg) [
              "vscode"
              "nvidia-x11"
              "google-chrome"
              "steam"
              "steam-unwrapped"
              "cuda-merged"
              "cuda_cuobjdump"
              "cuda_nvcc"
              "cuda_nvdisasm"
              "cuda_nvprune"
              "cuda_gdb"
              "cuda_cccl"
              "cuda_cudart"
              "cuda_cupti"
              "cuda_cuxxfilt"
              "libcufft"
              "libcurand"
              "libcusolver"
              "cuda_nvml_dev"
              "cuda_nvrtc"
              "cuda_nvtx"
              "cuda_profiler_api"
              "cuda_sanitizer_api"
              "libcublas"
              "cudatoolkit"
              "discord"
            ];
        };
      };
      pkgs-stable = nixpkgs-stable.legacyPackages.${system};
      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs pkgs pkgs-stable;
        };
        modules = [
          ./configuration.nix
          home-manager.nixosModules.default
        ];
      };

      homeConfigurations."incog267" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
      };
    };
}
