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

  stylix = {
    enable = true;
    autoEnable = true;
    targets = {
      lazygit.enable = true;
      hyprland.enable = true;
    };
  };
  home.sessionPath = [
    "$HOME/.config/nixCats-nvim/result/bin"
  ];

  home.sessionVariables = {
    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
  };
}
