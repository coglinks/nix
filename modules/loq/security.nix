{ ... }:

{
  services.gnome.gnome-keyring.enable = true;
  programs.mtr.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;
  security.rtkit.enable = true;
  programs.gnupg.agent = {
    enable = true;
  };
}
