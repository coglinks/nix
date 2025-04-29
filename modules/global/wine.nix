{ pkgs, ... }:

{
  environment.systemPackages = [
    # support both 32-bit and 64-bit applications
    pkgs.wineWowPackages.stable
    pkgs.winetricks
  ];
}
