{ pkgs-stable, ... }:

{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    package = pkgs-stable.yazi;
  };
}
