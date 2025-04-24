{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # support both 32-bit and 64-bit applications
    wineWowPackages.stable
    winetricks
  ];
}
