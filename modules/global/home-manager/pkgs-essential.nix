{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    antidote
    bat # cli #text-viewer #cat-with-syntax-highlighting 
    browsh
		biome
    feh
    tealdeer
    gnumake
    htop
    file
    vlock
    kitty # gui #terminal
    less
    libsecret
    mystmd
    nerd-fonts.iosevka # cli #fonts
    nerd-fonts.iosevka-term # cli #fonts
    pandoc # cli #converter
    rclone
    rsync
    stow # cli #dotfiles
    tokei # cli #coding
    topgrade
    trash-cli # cli #file-management
    udiskie
    vorta
    yazi # tui #file-mgr
    zoxide # tui
  ];
}
