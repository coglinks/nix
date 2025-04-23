{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
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

  fonts.packages = with pkgs; [
    nerd-fonts.iosevka-term
    nerd-fonts.iosevka
  ];
}
