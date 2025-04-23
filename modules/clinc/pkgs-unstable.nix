{ pkgs-unstable, ... }:

{
  programs.zsh.antidote = {
    enable = true;
    plugins = [
# set up Zsh completions with plugins
"mattmc3/ez-compinit"
"zsh-users/zsh-completions kind:fpath path:src"

# or lighter-weight ones like zsh-utils
"belak/zsh-utils path:editor"
"belak/zsh-utils path:history"
"belak/zsh-utils path:prompt"
"belak/zsh-utils path:utility"

# popular fish-like plugins
"mattmc3/zfunctions"
"zsh-users/zsh-autosuggestions"
"zdharma-continuum/fast-syntax-highlighting"
"zsh-users/zsh-history-substring-search"

# others
"qoomon/zsh-lazyload"
"romkatv/powerlevel10k"
	];		
  };
  home.packages = with pkgs-unstable; [
    bat # cli #text-viewer #cat-with-syntax-highlighting
    rclone
    antidote
    mystmd
    firefox
    git-lfs
    nodejs
    less
    borgbackup
    browsh
    feh
    vorta
    rsync
    git # cli #vcs #git-tools
    git-crypt # cli #encryption #git-tools
    git-remote-gcrypt # cli #encryption-plugin-for-git #git-tools
    kitty # gui #terminal
    lazygit # tui #vcs #git-tools
    lua-language-server # cli #lsp
    rocmPackages.llvm.clang # cli #compiler
    topgrade
    libsecret
    git-credential-manager
    lua5_1 # cli #programming-language
    luarocks # cli #package-manager
    neovim # tui #text-editor
    nerd-fonts.iosevka # cli #fonts
    nerd-fonts.iosevka-term # cli #fonts
    pandoc # cli #converter
    stow # cli #dotfiles
    tokei # cli #coding
    trash-cli # cli #file-management
    vim # tui #text-editor
    yazi # tui #file-mgr
    zoxide # tui
  ];
  fonts.fontconfig = {
    enable = true;
  };
}
