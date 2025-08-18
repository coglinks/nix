{
  config,
  inputs,
  lib,
  pkgs,
  pkgs-stable,
  pkgs-unstable,
  self,
  ...
}:

{
  # Optional, hint Electron apps to use Wayland:
  home.sessionVariables.NIXOS_OZONE_WL = "1";

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      # Keybinds
      source = ./hyprland-dot-conf/keybinds.conf

      # general
      source = ./hyprland-dot-conf/general.conf

      # Startup and environmental variables
      source = ./hyprland-dot-conf/startup.conf

      # Plugins
      source = ./hyprland-dot-conf/plugins.conf

      # monitor-rules
      source = ./hyprland-dot-conf/hardware.conf
      source = ./monitors.conf
      source = ./workspaces.conf

      # Decoration and Animations Settings
      source = ./hyprland-dot-conf/decor.conf
      '';
  };

  xdg.configFile = {
    "hypr/hyprland-dot-conf" = {
      source = config.lib.file.mkOutOfStoreSymlink ./hypr/hyprland-dot-conf;
      recursive = true;
    };
    "hypr/hyprlock-conf" = {
      source = config.lib.file.mkOutOfStoreSymlink ./hypr/hyprlock-conf;
      recursive = true;
    };
    "hypr/scripts" = {
      source = config.lib.file.mkOutOfStoreSymlink ./hypr/scripts;
      recursive = true;
    };
    "hypr/UserScripts" = {
      source = config.lib.file.mkOutOfStoreSymlink ./hypr/UserScripts;
      recursive = true;
    };
  };

  programs.hyprlock = {
    enable = true;
    package = pkgs-stable.hyprlock;
    extraConfig = builtins.readFile ./hypr/hyprlock.conf;
  };

  services.hypridle = {
    enable = true;
    package = pkgs-stable.hypridle;
    settings = { # Original config submitted by https://github.com/SherLock707, provided by JaKooLit
      general = {
          lock_cmd = "pidof hyprlock || hyprlock"; # runs hyprlock if it is not already running (this is always run when "loginctl lock-session" is called)
          # unlock_cmd = killall hyprlock # kills hyprlock when unlocking (this is always run when "loginctl unlock-session" is called)
          before_sleep_cmd = "loginctl lock-session";    # ensures that the session is locked before going to sleep
          after_sleep_cmd = "hyprctl dispatch dpms on"; # turn of screen after sleep (not strictly necessary, but just in case)
          ignore_dbus_inhibit = false;             # whether to ignore dbus-sent idle-inhibit requests (used by e.g. firefox or steam)
      };
      listener = [
        { # Warn
          timeout = 240; # 4 min
          on-timeout = "notify-send \"You are idle!\""; # command to run when timeout has passed
        }
        { # Screenlock
          timeout = 300; # 5 min
          on-timeout = "loginctl lock-session"; # command to run when timeout has passed
        }
        { # Suspend
          timeout = 600; # 10 min
          on-timeout = "systemctl suspend"; # command to run when timeout has passed
        }
        { # Hibernate
          timeout = 1800; # 30 min
          on-timeout = "systemctl hibernate"; # command to run when timeout has passed
        }
      ];
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = false;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

  home.packages = with pkgs-stable; [
    wayfreeze #Tool to freeze the screen of a Wayland compositor
    gradia
    nwg-displays
    xclip
    libnotify
    inputs.astal.packages.${system}.default
    blueman # gui
    cliphist # cli #clipboard-history
    grim # gui #screenshot #wayland
    networkmanager # cli #network
    slurp # cli #screenshot
    swww # gui #wallpaper
    networkmanager_dmenu # gui #network
    networkmanagerapplet # gui #network
    hyprpicker # cli #color-picker
    hyprpolkitagent # cli #polkit
    hyprshot
    inputs.iwmenu.packages.${pkgs.system}.default
    inputs.bzmenu.packages.${pkgs.system}.default
    copyq
    wlogout
  ];

  wayland.windowManager.hyprland.plugins = [
    # inputs.hyprtasking.packages.${pkgs.system}.hyprtasking
    # pkgs.hyprlandPlugins.hyprspace
    pkgs-unstable.hyprlandPlugins.hyprexpo
  ];
}
