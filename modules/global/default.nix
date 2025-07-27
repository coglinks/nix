{ ... }:

{
  imports = [
    ./desktop-env
    ./hardware
    ./styling
    ./boot.nix
    ./container.nix
    ./gaming.nix
    ./lanzaboote.nix
    ./nix.nix
    ./ollama.nix
    ./pkgs.nix
    ./security.nix
    ./user.nix
  ];

  home-manager.users.incogshift = {
    imports = [
      ./home-manager
    ];
  };
}
