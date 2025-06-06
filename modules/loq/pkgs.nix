{ pkgs, ... }:

{
  programs.obs-studio = {
    enable = true;
    enableVirtualCamera = true;
  };
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-esr;
  };
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 7d --keep 4";
    flake = "/home/incogshift/st/nix#loq";
  };
  environment.systemPackages = with pkgs; [
    libsForQt5.qt5ct
    kdePackages.qt6ct
    borgbackup
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
