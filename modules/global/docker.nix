{ pkgs, ... }:

{
  virtualisation.docker = {
    enable = false;
    daemon.settings = {
      data-root = "home/incogshift/dockerData-root";
    };
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  environment.systemPackages = [
    pkgs.lazydocker
  ];
}
