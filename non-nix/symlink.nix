{ config, lib, ... }:

{
  home.file.".bashrc".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/.bashrc;
# this shit (utter fucking bs) is broken
#  home.file.".config" = {
#    source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/.config;
#    recursive = true;
#  };
#  xdg.configFile."hypr/hyprland.conf".source = "hypr/hyprland.conf";
#  xdg.configFile."environment.d/10-home-manager.conf".enable = false;
#  xdg.configFile."fontconfig/conf.d/10-hm-fonts.conf".enable = false;
#  xdg.configFile."fontconfig/conf.d/52-hm-default-fonts.conf".enable = false;
#  xdg.configFile."systemd/user/hyprland-session.target".enable = false;
#  xdg.configFile."git/config".enable = false;
#  xdg.configFile."systemd/user/tray.target".enable = false;

  home.file."custom" = {
    source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/custom;
    recursive = true;
  };
  home.file.".ollama".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/.ollama;
  home.file."texmf" = {
    source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/texmf;
    recursive = true;
  };
  home.file.".vscode" = {
    source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/.vscode;
    recursive = true;
  };
  home.file.".zsh_plugins.txt".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/.zsh_plugins.txt;
  home.file.".zshrc".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/.zshrc;
}
