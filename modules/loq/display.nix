{ pkgs, ... }:

{

  programs = {
    hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };
  };

  services.xremap = {
    withHypr = true;
    userName = "incogshift";
    yamlConfig = ''
      keymap:
        - name: power;
          remap:
            super-z:
              launch: ["$HOME/.config/rofi/launchers/type-3/launcher.sh"]
    '';
  };
  security.pam.services.hyprlock = { };
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.sddm.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  # XDG portal
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  environment = {
    sessionVariables = {
      # Hint electron apps to use wayland
      NIXOS_OZONE_WL = "1";
    };
  };
}
