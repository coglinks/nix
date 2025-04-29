{
  lib,
  inputs,
  config,
  pkgs,
  ...
}:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "incogshift";
  home.homeDirectory = "/home/incogshift";

  nixpkgs.config.allowUnfree = true;

  imports = [
    ./modules/global/home-manager/git.nix
    ./modules/global/home-manager/hyprland.nix
    ./modules/global/home-manager/pkgs-essential.nix
    ./modules/loq/hm-pkgs.nix
  ];

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  #home.sessionVariables = {
  #  EDITOR = "nvim";
  #};

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
