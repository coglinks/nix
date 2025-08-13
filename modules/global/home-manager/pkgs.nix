{
  config,
  inputs,
  lib,
  pkgs,
  pkgs-stable,
  self,
  ...
}:

{
  home.packages = with pkgs-stable; [
    veracrypt
    thunderbird
    spicetify-cli
    spotify
    gnome-sound-recorder
    nautilus
    mpv
    libreoffice
    ardour #DAW
    bitwarden-desktop # gui #security
    audacity
    feh
    qimgv
    reaper
    vorta
    cava
    sonic-visualiser
    # geeqie
    gvfs
    meld # gui #Visual diff and merge tool
    brightnessctl # cli #system-tools
    # darktable # gui #photo-editing
    ddcutil # cli #monitor-control
    discord # gui #communication
    firewalld # cli #security
    gimp # gui #image-editor
    google-chrome # gui #browser
    imagemagick # cli #image-tools
    inkscape # gui #vector-editor
    kitty # gui #terminal
    pamixer # cli #audio
    pandoc # cli #converter
    pavucontrol # gui #audio
    pdfchain # gui #pdf-tools
    pdftk # cli #pdf-tools
    pinentry-tty # cli #gnupg-interface-to-passphrase-input
    pkg-config # cli #pkg-builder
    playerctl # cli #media
    powertop # cli #power
    swappy # gui #screenshot
    swaynotificationcenter # gui #notifications
    texlive.combined.scheme-full # cli #programming-language
    tigervnc # gui #screen-share
    tokei # cli #coding
    topgrade # cli #pkg-management
    tpm2-tss # cli #security
    trash-cli # cli #file-management
    wayland # cli #display-server
    wayland-protocols # cli #dependency
    win-spice # cli #dependency
    xournalpp # gui
    youtube-music # gui
    zathura # tui
  ];
  fonts.fontconfig = {
    enable = true;
  };


  programs = {
    info.enable = true;
    man = {
      enable = true;
    };
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
      "application/pdf"="org.pwmt.zathura.desktop";
      "image/jpeg"="feh.desktop";
      "image/png"="feh.desktop";
      "image/jpg"="feh.desktop";
      "image/webp"="feh.desktop";
      "image/gif"="feh.desktop";
    };
  };

  xdg.configFile."cava/config".source = config.lib.file.mkOutOfStoreSymlink ./cava/config;
}
