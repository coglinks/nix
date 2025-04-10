{ pkgs-unstable, ... }:

{
  home.packages = with pkgs-unstable; [
    bat #cli #text-viewer #cat-with-syntax-highlighting
    rclone
    firefox
    borgbackup
    browsh
    vorta
    rsync
    git #cli #vcs #git-tools
    git-crypt #cli #encryption #git-tools
    git-remote-gcrypt #cli #encryption-plugin-for-git #git-tools
    kitty #gui #terminal
    lazygit #tui #vcs #git-tools
    lua-language-server #cli #lsp
    rocmPackages.llvm.clang #cli #compiler
    libsecret
    git-credential-manager
    lua5_1 #cli #programming-language
    luarocks #cli #package-manager
    neovim #tui #text-editor
    nerd-fonts.iosevka #cli #fonts
    nerd-fonts.iosevka-term #cli #fonts
    pandoc #cli #converter
    stow #cli #dotfiles
    tokei #cli #coding
    trash-cli #cli #file-management
    vim #tui #text-editor
    yazi #tui #file-mgr
    zoxide #tui
  ];
  fonts.fontconfig = {
    enable = true;
  };
}
