{ pkgs-unstable, ...}:

{
   environment.systemPackages = 
    with pkgs-unstable; [
      win-virtio
      seahorse
      libsecret
      git-credential-manager

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
    (pkgs.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      })
    )
    ];

fonts.packages = with pkgs-unstable; [ 
  nerd-fonts.iosevka-term
  nerd-fonts.iosevka
  ];
}
