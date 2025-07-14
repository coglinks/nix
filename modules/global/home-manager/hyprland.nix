{
  lib,
  self,
  inputs,
  config,
  pkgs,
  ...
}:

{
  # Optional, hint Electron apps to use Wayland:
  home.sessionVariables.NIXOS_OZONE_WL = "1";

  wayland.windowManager.hyprland = {
    enable = true;
    # set the Hyprland and XDPH packages to null to use the ones from the NixOS module
    package = null;
    portalPackage = null;
    extraConfig = builtins.readFile ./hypr/hyprland.conf;
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = false;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

    home.packages = with pkgs; [
      wayfreeze
      killall
    ];

    wayland.windowManager.hyprland.plugins = [
      inputs.hyprtasking.packages.${pkgs.system}.hyprtasking
    ];

}
