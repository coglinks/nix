{ pkgs, pkgs-stable, config, ... }:

{
  home.packages = with pkgs-stable; [
    bat # cli #text-viewer #cat-with-syntax-highlighting 
    killall
    rclone
    nixd
    nixfmt-rfc-style
    borgbackup # cli #backup
    cryptsetup # cli #security #system-tools
    stow # cli #dotfiles
    wget # cli
    wl-clipboard # cli
    htop
    tree
    timewarrior
    feh
    tealdeer
    htop
    file
    vlock
    kitty # gui #terminal
    omnix
    less
    libsecret
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
  ];
  programs.zoxide = {
    enable = true;
    package = pkgs-stable.zoxide;
    enableZshIntegration = true;
  };
}
