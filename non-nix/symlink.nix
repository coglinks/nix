{ ... }:

{
  home.file.".bashrc".source = ./dotfiles/.bashrc;
  home.file.".config".source = ./dotfiles/.config;
  home.file."custom".source = ./dotfiles/custom;
  home.file.".ollama".source = ./dotfiles/.ollama;
  home.file."texmf".source = ./dotfiles/texmf;
  home.file.".vscode".source = ./dotfiles/.vscode;
  home.file.".zsh_plugins.txt".source = ./dotfiles/.zsh_plugins.txt;
  home.file.".zshrc".source = ./dotfiles/.zshrc;
}
