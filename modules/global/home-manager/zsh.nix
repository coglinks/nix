{ lib, ... }:

{
  programs.zsh = {
    enable = true;
    history = {
      size = 10000;
      append = true;
    };
    initContent =
      let
        zshConfigEarlyInit = lib.mkOrder 500
          # zsh
          ''
            # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
            # Initialization code that may require console input (password prompts, [y/n]
            # confirmations, etc.) must go above this block; everything else may go below.
            if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
              source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
            fi
          '';
        zshConfig = lib.mkOrder 1000
          # zsh
          ''
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
        zshConfigLateInit = lib.mkOrder 1500
          # zsh
          ''
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
}
