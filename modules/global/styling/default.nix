{ inputs, lib, ... }:

{
  stylix = {
    enable = true;
    base16Scheme = ./assets/dark-palette.yaml;
    pallete = "dark";
    targets.gnome.enable = false;
  };

  # specialisation.light.configuration = {
  #   stylix = {
  #     base16Scheme = lib.mkForce ./assets/light-pallete.yaml;
  #     pallete = lib.mkForce "light";
  #   };
  # };

  home-manager.users.incogshift = {
    stylix = {
      enable = true;
    };
  };
}
