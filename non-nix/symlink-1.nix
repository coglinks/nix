{ config, ... }:

let
  dotfilesDir = ./dotfiles;

  # Read top-level dotfiles entries
  entries = builtins.readDir dotfilesDir;

  # Helper to safely generate file entries
  mkFile = name: {
    name = name;
    value.source = config.lib.file.mkOutOfStoreSymlink (dotfilesDir + "/${name}");
  };

  # Top-level dotfiles (like .bashrc, .zshrc, .config, etc.)
  topLevelFiles = builtins.filter (name: name != ".config") (builtins.attrNames entries);

  # .config subdirs, except hypr/hyprland
  configDir = "${dotfilesDir}/.config";
  configEntries = builtins.readDir configDir;

  configFiles = builtins.filter (name:
    let
      fullPath = "${configDir}/${name}";
    in
      # Skip "hypr" since we will check subdir manually
      name != "hypr"
  ) (builtins.attrNames configEntries);

  # Include .config/hypr/* except hyprland
  hyprDir = "${configDir}/hypr";
  hyprEntries = builtins.readDir hyprDir;

  hyprSubFiles = builtins.filter (name: name != "hyprland") (builtins.attrNames hyprEntries);

in {
  home.file = builtins.listToAttrs (
    map mkFile topLevelFiles
    ++ map (name: {
      name = ".config/${name}";
      value.source = config.lib.file.mkOutOfStoreSymlink (configDir + "/${name}");
    }) configFiles
    ++ map (name: {
      name = ".config/hypr/${name}";
      value.source = config.lib.file.mkOutOfStoreSymlink (hyprDir + "/${name}");
    }) hyprSubFiles
  );
}


