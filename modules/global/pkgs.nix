{ pkgs, pkgs-stable, pkgs-unstable, ... }:

{
  programs.obs-studio = {
    enable = true;
    package = pkgs-stable.obs-studio;
    enableVirtualCamera = true;
  };
  programs.firefox = {
    enable = true;
    package = pkgs-stable.firefox;
  };
  programs.vim.enable = true;
  environment.systemPackages = with pkgs-stable; [
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
    waybar
  ];

  documentation = {
    nixos = {
      enable = true;
    };
    info.enable = true;
    man = {
      enable = true;
      man-db = {
        enable = true;
      };
    };
  };

  fonts.packages = with pkgs-unstable; [
    nerd-fonts.iosevka-term
    nerd-fonts.iosevka
  ];
}
