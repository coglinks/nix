{ pkgs, ... }:

{

  environment = {
    sessionVariables = {
      # Hint electron apps to use wayland
      NIXOS_OZONE_WL = "1";
    };
  };
  programs = {
    hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };
  };

  security.pam.services.hyprlock = { };

  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm;
    theme = "${import ./sddm.nix { inherit pkgs; }}";
    extraPackages = [ pkgs.sddm-astronaut ];
  };

  environment.systemPackages = with pkgs; [sddm-astronaut];

  # Configure keymap in X11
  services.xserver.xkb = {
    enable = true;
    layout = "us";
    variant = "";
  };

  # XDG portal
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
}
