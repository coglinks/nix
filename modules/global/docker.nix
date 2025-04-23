{ ... }:

{
  #  users.users.incogshift = {
  #    extraGroups = [ "docker" ];
  #  };

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

  #  systemd.user.services.docker = {
  #    enable = true;
  #    wantedBy = ["multi-user.target"];
  #  };
}
