{ pkgs, lib, ... }:

{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    package = pkgs.yazi;
  };
  # zsh shell wrapper: change the current working directory when exiting Yazi
  programs.zsh.initContent = lib.mkOrder 1000
    # bash
    ''
      function y() {
        local tmp="''$(mktemp -t "yazi-cwd.XXXXXX")" cwd
        yazi "''$@" --cwd-file="''$tmp"
        IFS= read -r -d ''' cwd < "''$tmp"
        [ -n "''$cwd" ] && [ "''$cwd" != "''$PWD" ] && builtin cd -- "''$cwd"
        rm -f -- "$tmp"
      }
    '';
}
