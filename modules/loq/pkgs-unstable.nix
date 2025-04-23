{ pkgs-unstable, ... }:

{
  environment.systemPackages = with pkgs-unstable; [
    win-virtio
    seahorse
    sbctl
    libsecret
    pciutils
    git-credential-manager

    (pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    }))
  ];

  fonts.packages = with pkgs-unstable; [
    nerd-fonts.iosevka-term
    nerd-fonts.iosevka
  ];
}
