{
  hyprland,
  system,
  pkgs,
  pkgs-stable,
  pkgs-unstable,
  ...
}:

{
  # The following is used as a backup in case Hyprland stops working
  services.desktopManager.gnome.enable = true;

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };
  environment = {
    sessionVariables = {
      # Hint electron apps to use wayland
      NIXOS_OZONE_WL = "1";
    };
  };
  programs = {
    hyprland = {
      # package = hyprland.packages.${system}.default;
      package = pkgs-unstable.hyprland;
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };
  };

  home-manager.users.incogshift = {
    wayland.windowManager.hyprland = {
      # set the Hyprland and XDPH packages to null to use the ones from the NixOS module
      package = null;
      portalPackage = null;
    };
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ 
      pkgs.xdg-desktop-portal-gtk
    ];
  };
  security.pam.services.hyprland.enableGnomeKeyring = true;
  services.seatd.enable = true;
  security.polkit.enable = true;

  security.pam.services.hyprlock = { };
}
