{ pkgs-stable, ... }:

{
  programs.tmux = {
    enable = true;
    package = pkgs-stable.tmux;
    plugins = with pkgs-stable; [
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

      # nvim: `escape-time` (500) is higher than 300ms
      set-option -sg escape-time 10

      # nvim: focus-events` is not enabled. |'autoread'| may not work.
      set-option -g focus-events on

      # nvim: $TERM should be "screen-256color" or "tmux-256color" in tmux. Colors might look wrong.
      set-option -g default-terminal "screen-256color"
    '';
  };
}
