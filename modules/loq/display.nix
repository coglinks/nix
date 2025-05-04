{ pkgs, hyprland, system, ... }:

{

  environment = {
    sessionVariables = {
      # Hint electron apps to use wayland
      NIXOS_OZONE_WL = "1";
    };
  };
  programs = {
    hyprland = {
      package = hyprland.packages.${system}.default;
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };
  };

  security.pam.services.hyprlock = { };

  services.xserver.desktopManager.gnome.enable = true;

  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm;
    theme = "${import ./sddm.nix { inherit pkgs; }}";
    extraPackages = [ pkgs.sddm-astronaut ];
  };

  environment.systemPackages = with pkgs; [sddm-astronaut];

  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # XDG portal
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
}
