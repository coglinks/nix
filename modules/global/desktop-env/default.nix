{ ... }:

{
  imports = [
    ./display-manager.nix
    ./hyprland.nix
  ];

  home-manager.users.incogshift = {
    imports = [ ./home-manager ];
  };
}
