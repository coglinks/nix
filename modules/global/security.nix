{ pkgs-stable, ... }:

{
  services.gnome.gnome-keyring.enable = true;
  programs.mtr = {
    enable = true;
    package = pkgs-stable.mtr;
  };
  security.pam.services.sddm.enableGnomeKeyring = true;
  security.rtkit.enable = true;
  programs.gnupg.agent = {
    enable = true;
  };
}
