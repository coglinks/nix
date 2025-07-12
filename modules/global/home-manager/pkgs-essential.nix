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
    quarto
    conda
  ];
  programs.tmux = {
  enable = true;
  plugins = with pkgs; [
      tmuxPlugins.resurrect
      tmuxPlugins.continuum
      tmuxPlugins.tmux-sessionx
    ];
  keyMode = "vi";
  newSession = false;
  extraConfig =
    # bash
    ''
    #- [t] - NOTE: Tools

    bind "t" switch-client -T "TOOLS" \; display-message "TOOLS: [g]-Lazygit"
    bind -T "TOOLS" "g" display-popup -w "100%" -h "100%" -d "#{pane_current_path}" -E "lazygit"

    # NOTE: Preferences

    set -g mouse on

    # image.nvim setup

    set -gq allow-passthrough on
    set -g visual-activity off

    ## plugin setups

    set -g @sessionx-bind 'o'
  '';
  };
}
