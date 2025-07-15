{ pkgs, ... }:

{
  programs.rofi = {
    package = pkgs.rofi-wayland;
    enable = true;
  };
  stylix.targets.rofi.enable = true;
}
