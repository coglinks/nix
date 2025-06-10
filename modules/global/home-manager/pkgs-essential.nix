{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
viAlias = true;
    extraPackages = with pkgs; [
      # Language server packages (executables)
			lua-language-server
			tree-sitter
			libgcc
			deno
			marksman
			python313Packages.pylatexenc
			luajitPackages.jsregexp
    ];
  };
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
    libgcc #nvim dependancy
    zoxide # tui
  ];
}
