# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  pkgs-stable,
  pkgs-unstable,
  lib,
  inputs,
  ...
}:

{
  imports = [
    ./modules
    ./modules/devices/loq
  ];

# What follows is base system setup

  # Set your time zone.
  time.timeZone = "Asia/Qatar";

  home-manager = {
    # also pass inputs to home-manager modules
    extraSpecialArgs = {
      inherit inputs;
      inherit pkgs;
      inherit pkgs-stable;
      inherit pkgs-unstable;
    };
    users.incogshift = import ./home.nix;
    useUserPackages = true;
  };
}
