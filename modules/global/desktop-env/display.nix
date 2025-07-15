{ pkgs, system, ... }:

{
  services.desktopManager.gnome.enable = true;

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
}
