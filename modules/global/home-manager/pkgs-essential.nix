{ pkgs, ... }:

{
  home.packages = with pkgs; [
    antidote
    bat # cli #text-viewer #cat-with-syntax-highlighting
    borgbackup
    browsh
    feh
    firefox
    git # cli #vcs #git-tools
    git-credential-manager
    git-crypt # cli #encryption #git-tools
    git-lfs
    git-remote-gcrypt # cli #encryption-plugin-for-git #git-tools
    kitty # gui #terminal
    lazygit # tui #vcs #git-tools
    less
    libsecret
    lua-language-server # cli #lsp
    lua5_1 # cli #programming-language
    luarocks # cli #package-manager
    mystmd
    neovim # tui #text-editor
    nerd-fonts.iosevka # cli #fonts
    nerd-fonts.iosevka-term # cli #fonts
    nodejs
    pandoc # cli #converter
    rclone
    rocmPackages.llvm.clang # cli #compiler
    rsync
    stow # cli #dotfiles
    tokei # cli #coding
    topgrade
    trash-cli # cli #file-management
    udiskie
    vim # tui #text-editor
    vorta
    yazi # tui #file-mgr
    zoxide # tui
  ];
}
