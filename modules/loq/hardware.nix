{ ... }:

{
  # Configure hibernation with resume
  #boot.kernelParams = [
  #  "resume=/dev/nvme0n1p3"
  #];
  
  #boot.resumeDevice = "/dev/disk/by-uuid/60d58fec-52a7-4599-a5d7-0dafe15e53ae";
  boot.loader.systemd-boot.enable = true;  
  boot.initrd.systemd.enable = true;
  zramSwap.enable = true;
  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Enable power management for hibernation
  powerManagement.enable = true;
  powerManagement.powertop.enable = true; # enable powertop auto tuning on startup.

  services.system76-scheduler.settings.cfsProfiles.enable = true; # Better scheduling for CPU cycles - thanks System76!!!
  services.thermald.enable = true; # Enable thermald, the temperature management daemon. (only necessary if on Intel CPUs)
  services.power-profiles-daemon.enable = false; # Disable GNOMEs power management
  services.tlp = {
    # Enable TLP (better than gnomes internal power manager)
    enable = true;
    settings = {
      # sudo tlp-stat or tlp-stat -s or sudo tlp-stat -p
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;
      CPU_HWP_DYN_BOOST_ON_AC = 1;
      CPU_HWP_DYN_BOOST_ON_BAT = 0;
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
      CPU_SCALING_MIN_FREQ_ON_AC = 400000; # 400 MHz
      CPU_SCALING_MAX_FREQ_ON_AC = 4200000; # 4,2 GHz
      START_CHARGE_THRESH_BAT0 = 40;
      STOP_CHARGE_THRESH_BAT0 = 81;
    };
  };
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  hardware.bluetooth.enable = true;


  services.blueman.enable = true;
}
