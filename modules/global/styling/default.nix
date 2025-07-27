{ inputs, lib, ... }:

{
  stylix = {
    enable = true;
    base16Scheme = ./assets/dark-palette.yaml;
    targets.gnome.enable = false;
  };

  # specialisation.light.configuration = {
  #   stylix = {
  #     base16Scheme = lib.mkForce ./assets/light-pallete.yaml;
  #   };
  # };

  home-manager.users.incogshift = {
    stylix = {
      enable = true;
    };
  };
}
