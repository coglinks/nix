{ pkgs, ... }:

{
  systemd.timers."git-repo-backup" = {
    wantedBy = [ "timers.target" ];
      timerConfig = {
        Persistent = true;
        OnCalendar = "daily";
      };
  };

  systemd.services."git-repo-backup" = {
    script = ''
      ${pkgs.gnutar}/bin/tar cvf /home/incogshift/st/gitrepos.tar /home/incogshift/st/nix /home/incogshift/st/notes
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "incogshift";
    };
  };
}
