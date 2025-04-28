# configuration.nix

{ pkgs, inputs, config, ... }:

{
  sops.defaultSopsFile = ./secrets/example.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.secrets."myservice/my_subdir/my_secret" = {
    owner = "incogshift";
  };
  
  systemd.services."incogshift" = {
    script = ''
        echo "
        Hey bro! I'm a service, and imma send this secure password:
        $(cat ${config.sops.secrets."myservice/my_subdir/my_secret".path})
        located in:
        ${config.sops.secrets."myservice/my_subdir/my_secret".path}
        to database and hack the mainframe
        " > /var/lib/incogshift/testfile
      '';
    serviceConfig = {
      User = "incogshift";
      WorkingDirectory = "/var/lib/incogshift";
    };
  };
}
