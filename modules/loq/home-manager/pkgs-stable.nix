{ pkgs-unstable, ... }:

{
  home.packages = with pkgs-unstable; [
        hyprlock #cli #lockscreen
  ];
}
