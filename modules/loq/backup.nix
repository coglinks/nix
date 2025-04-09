{ config, pkgs, ... }:

{
  # Define the rclone sync service
  systemd.user.services."rclone-sync" = {
    enable = true;
    script = ''
      ${pkgs.rclone}/bin/rclone sync /home/incog267/clones/notes --exclude /home/incog267/clones/notes/.git gdrive-loq:loq-backup
    '';
    serviceConfig = {
      User = "incog267";
    };
    wantedBy = [ "timers.target" ];
  };

  # Define the timer to run the sync daily
  systemd.user.timers."rclone-sync" = {
    description = "Run 'Sync notes to Google Drive via rclone' every day";
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
    };
    wantedBy = [ "timers.target" ];
  };
}
