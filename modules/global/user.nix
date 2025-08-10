{ pkgs-stable, ... }:

{
  # Don't forget to set a password with ‘passwd’.
  users.users.incogshift = {
    isNormalUser = true;
    description = "incogshift";
    extraGroups = [ "networkmanager" "wheel" "adb" "input" ];
    shell = pkgs-stable.zsh;
  };
}
