{ pkgs-stable, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs-stable.rofi-wayland;
  };
  stylix.targets.rofi.enable = true;
}
