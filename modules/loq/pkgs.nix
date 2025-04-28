{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    tpm2-tss
    sops
    age
    gparted
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
