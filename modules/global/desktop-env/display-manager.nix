{ pkgs-stable, system, ... }:

{
  services.displayManager.sddm = {
    enable = true;
    package = pkgs-stable.kdePackages.sddm;
    theme = "${import ./sddm.nix { inherit pkgs-stable; }}";
    extraPackages = [ pkgs-stable.sddm-astronaut ];
  };

  environment.systemPackages = with pkgs-stable; [sddm-astronaut];

  services.xserver = {
    enable = true;
    # Configure keymap in X11
    xkb = {
      layout = "us";
      variant = "";
    };
  };
}
