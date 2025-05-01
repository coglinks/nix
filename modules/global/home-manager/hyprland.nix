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

  #  programs.kitty.enable = true;
  #
  wayland.windowManager.hyprland = {
    enable = true;
    # set the Hyprland and XDPH packages to null to use the ones from the NixOS module
    package = null;
    portalPackage = null;
    extraConfig = ''
      source = ./hyprland.conf.hm-bkp
    '';
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = false;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

    home.packages = with pkgs; [
      #
    ];

    wayland.windowManager.hyprland.plugins = [
      pkgs.hyprlandPlugins.hyprspace
      pkgs.hyprlandPlugins.hyprexpo
      #(pkgs.callPackage ./plugin.nix {})
      # inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
      #inputs.hyprtasking.packages.${pkgs.system}.hyprtasking
    ];

}
