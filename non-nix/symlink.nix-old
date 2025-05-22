{ config, ... }:

{
  home.file.".bashrc".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/.bashrc;
  #home.file.".config".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/.config;
  home.file."custom".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/custom;
  home.file.".ollama".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/.ollama;
  home.file."texmf".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/texmf;
  home.file.".vscode".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/.vscode;
  home.file.".zsh_plugins.txt".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/.zsh_plugins.txt;
  home.file.".zshrc".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/.zshrc;

  xdg.configFile."cava".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/.config/cava;
  xdg.configFile."kitty".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/.config/kitty;
  xdg.configFile."lazygit".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/.config/lazygit;
  xdg.configFile."mimeapps.list".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/.config/mimeapps.list;
  xdg.configFile."nix".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/.config/nix;
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/.config/nvim;
  xdg.configFile."ranger".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/.config/ranger;
  xdg.configFile."rclone".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/.config/rclone;
  xdg.configFile."rofi".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/.config/rofi;
  xdg.configFile."swaync".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/.config/swaync;
  xdg.configFile."tmux".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/.config/tmux;
  xdg.configFile."topgrade.toml".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/.config/topgrade.toml;
  xdg.configFile."waybar".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/.config/waybar;
  xdg.configFile."yazi".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/.config/yazi;
  xdg.configFile."zathura".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/.config/zathura;

  xdg.configFile = {
    "hypr/broken".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/.config/hypr/broken;
    "hypr/hypridle.conf".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/.config/hypr/hypridle.conf;
    "hypr/hyprland.conf.add-nix".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/.config/hypr/hyprland.conf.add-nix;
    "hypr/hyprland-dot-config".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/.config/hypr/hyprland-dot-config;
    "hypr/hyprlock-2k.conf".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/.config/hypr/hyprlock-2k.conf;
    "hypr/hyprlock-conf".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/.config/hypr/hyprlock-conf;
    "hypr/hyprlock.conf".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/.config/hypr/hyprlock.conf;
    "hypr/initial-boot.sh".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/.config/hypr/initial-boot.sh;
    "hypr/.initial_startup_done".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/.config/hypr/.initial_startup_done;
    "hypr/pyprland.toml".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/.config/hypr/pyprland.toml;
    "hypr/scripts".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/.config/hypr/scripts;
    "hypr/UserScripts".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/.config/hypr/UserScripts;
    "hypr/v2.3.8".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/.config/hypr/v2.3.8;
    "hypr/wallpaper_effects".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/.config/hypr/wallpaper_effects;
    "hypr/wallust".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/.config/hypr/wallust;
  };
}
