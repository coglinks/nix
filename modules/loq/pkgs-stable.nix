{ pkgs-stable, ...}:

{
   environment.systemPackages = 
    with pkgs-stable; [
      rclone
      spicetify-cli
      spotify
      mpv
      libreoffice
      devenv
      nodejs_23
      mystmd
      jupyter
    ];
}
