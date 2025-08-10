{ pkgs, pkgs-stable, ... }:

{
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Prevents suspend of mouse after a few seconds
  # You might be able to use `usbcore.autosuspend=-1` to disable entirely
  # ref = https://discourse.nixos.org/t/turn-off-autosuspend-for-usb/58933
  boot.kernelParams = [
    "usbcore.autosuspend=-1"
  ]; # if autosuspend=120 => wait for 2 minutes.

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
  environment.systemPackages = with pkgs-stable; [
    libinput-gestures
  ];
}
