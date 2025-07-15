{
  lib,
  inputs,
  config,
  pkgs,
  ...
}:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "incogshift";
  home.homeDirectory = "/home/incogshift";

  nixpkgs.config.allowUnfree = true;

  imports = [
    ./modules/global/home-manager/git.nix
    ./modules/global/desktop-env/hyprland-hm.nix
    ./modules/global/home-manager/pkgs-essential.nix
    ./modules/global/home-manager/tmux.nix
    ./modules/global/home-manager/rofi.nix
    ./modules/global/home-manager/yazi.nix
    ./modules/global/home-manager/pkgs.nix
    ./modules/global/home-manager/nvim.nix
#    ./non-nix/symlink.nix
    ./non-nix/programs/desktop-entries.nix
    ./modules/global/home-manager/general-settings.nix
  ];

  stylix = {
    enable = true;
    autoEnable = true;
    targets = {
      lazygit.enable = true;
      hyprland.enable = true;
    };
  };
  programs.zsh = {
    enable = true;
    history = {
      size = 10000;
      append = true;
    };
    initContent =
      let
        zshConfigEarlyInit = lib.mkOrder 500 ''
          # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
          # Initialization code that may require console input (password prompts, [y/n]
          # confirmations, etc.) must go above this block; everything else may go below.
          if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
            source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
          fi
        '';
        zshConfig = lib.mkOrder 1000 ''
          # yazi shell wrapper
          function y() {
            local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
            yazi "$@" --cwd-file="$tmp"
            if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
              builtin cd -- "$cwd"
            fi
            rm -f -- "$tmp"
          }

          # zoxide stuff
          eval "$(zoxide init zsh)"

          url() {
              local link="$1"
              local name="$2"
              local filepath="./''${name}.url"

              echo "[InternetShortcut]
          URL=''${link}" > "$filepath"

              chmod +x "$filepath"
              echo "Shortcut created: $filepath"
          }
          export PATH="$HOME/.config/nixCats-nvim/result/bin:$PATH"
        '';
        zshConfigLateInit = lib.mkOrder 1500 ''
          # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
          [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
        '';
      in
      lib.mkMerge [
        zshConfigEarlyInit
        zshConfig
        zshConfigLateInit
      ];
    antidote = {
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
  };

  home.sessionPath = [
    "$HOME/.config/nixCats-nvim/result/bin"
  ];

  home.sessionVariables = {
    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
