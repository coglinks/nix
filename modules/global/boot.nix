{ pkgs-stable, ... }:

{
  boot = {
    initrd.systemd = {
      enable = true;
      package = pkgs-stable.systemd;
    };
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };
}
