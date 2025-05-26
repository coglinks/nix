{ pkgs, ... }:

{
  # Don't forget to set a password with ‘passwd’.
  users.users.incogshift = {
    isNormalUser = true;
    description = "incogshift";
    extraGroups = [ "networkmanager" "wheel" "adb" "input" ];
    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;
}
