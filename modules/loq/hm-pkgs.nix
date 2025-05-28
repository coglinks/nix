{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    bat # cli #text-viewer #cat-with-syntax-highlighting
    inputs.iwmenu.packages.${pkgs.system}.default
    xclip
    inputs.bzmenu.packages.${pkgs.system}.default
    libnotify
    rclone
    inputs.astal.packages.${system}.default
    hyprshot
    hyprlock # cli #lockscreen
    timewarrior
    veracrypt
    git-annex
    nixd
    thunderbird
    spicetify-cli
    gnome-sound-recorder
    nautilus
    conda
    htop
    tree
    spotify
    mpv
    libreoffice
    devenv
    nodejs_23
    mystmd
    ardour
    bitwarden-desktop # gui #security
    blueman # gui
    audacity
    nixfmt-rfc-style
    feh
    qimgv
    reaper
    borgbackup # cli #backup
    vorta
    cava
    sonic-visualiser
    gvfs
    geeqie
    meld # gui #Visual diff and merge tool
    swaylock
    brightnessctl # cli #system-tools
    chezmoi # cli #file-management
    cliphist # cli #clipboard-history
    tmux
    cpio # cli #dependency
    cryptsetup # cli #security #system-tools
    darktable # gui #photo-editing
    ddcutil # cli #monitor-control
    discord # gui #communication
    firewalld # cli #security
    ghostscript # cli #pdf-tools
    gimp # gui #image-editor
    gnupg # cli #encryption
    go # cli #programming-language
    google-chrome # gui #browser
    grim # gui #screenshot #wayland
    hypridle # cli #wayland
    hyprlandPlugins.hyprspace # gui #hyprland
    hyprpicker # cli #color-picker
    hyprpolkitagent # cli #polkit
    imagemagick # cli #image-tools
    inkscape # gui #vector-editor
    inotify-tools # cli #filesystem
    jq # cli #json
    kdePackages.okular # gui
    kicad # gui #electronics
    kitty # gui #terminal
    lua-language-server # cli #lsp
    lua5_1 # cli #programming-language
    luarocks # cli #package-manager
    lutris # gui #gaming
    man # cli
    mellowplayer # gui #music
    mesa # cli #graphics
    mesa-demos # cli #collection-of-demos-and-test-programs-for-opengl-and-mesa
    meson # cli #build-system
    neovim # tui #text-editor
    nerd-fonts.iosevka # cli #fonts
    nerd-fonts.iosevka-term # cli #fonts
    networkmanager # cli #network
    networkmanager_dmenu # gui #network
    networkmanagerapplet # gui #network
    ninja # cli #build-system
    pamixer # cli #audio
    pandoc # cli #converter
    pavucontrol # gui #audio
    pdfchain # gui #pdf-tools
    pdftk # cli #pdf-tools
    pinentry-tty # cli #gnupg-interface-to-passphrase-input
    pkg-config # cli #pkg-builder
    playerctl # cli #media
    powertop # cli #power
    rclone # cli #cloud
    rofi-wayland # gui #launcher
    slurp # cli #screenshot
    steam # gui #gaming
    stow # cli #dotfiles
    swappy # gui #screenshot
    swaynotificationcenter # gui #notifications
    swww # gui #wallpaper
    texlive.combined.scheme-full # cli #programming-language
    tigervnc # gui #screen-share
    tokei # cli #coding
    topgrade # cli #pkg-management
    tpm2-tss # cli #security
    trash-cli # cli #file-management
    unzip # cli #compression-tool
    vim # tui #text-editor
    vscode # gui #ide
    wallust # gui #wallpaper
    wayland # cli #display-server
    wayland-protocols # cli #dependency
    wget # cli
    win-spice # cli #dependency
    wl-clipboard # cli
    xournalpp # gui
    yazi # tui #file-mgr
    youtube-music # gui
    zathura # tui
    zip # cli #compression-tool
    zoxide # tui
  ];
  fonts.fontconfig = {
    enable = true;
  };
  programs.firefox.enable = true;

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
}
