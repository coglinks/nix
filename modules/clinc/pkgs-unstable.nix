{ pkgs, ... }:

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
  fonts.fontconfig = {
    enable = true;
  };
}
