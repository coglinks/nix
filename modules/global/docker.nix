{ ... }:

{
  #  users.users.incog267 = {
  #    extraGroups = [ "docker" ];
  #  };

  virtualisation.docker = {
    enable = false;
    daemon.settings = {
      data-root = "home/incog267/dockerData-root";
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
