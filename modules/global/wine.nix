{ pkgs-unstable, ... }:

{
  environment.systemPackages = with pkgs-unstable; [
    #dotnetCorePackages.sdk_9_0_1xx
    #dotnetCorePackages.sdk_6_0_1xx
    dotnetCorePackages.sdk_5_0
    # support both 32-bit and 64-bit applications
    wineWowPackages.stable
    # support 32-bit only
    wine
    # support 64-bit only
    (wine.override { wineBuild = "wine64"; })
    wine64
    # wine-staging (version with experimental features)
    wineWowPackages.staging
    # winetricks (all versions)
    winetricks
    # native wayland support (unstable)
    wineWowPackages.waylandFull

  ];
}
