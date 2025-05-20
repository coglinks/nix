{
  config,
  lib,
  pkgs,
  ...
}:

#Nvidia settings for hybrid graphics(Intel and Nvidia)
# https://wiki.nixos.org/wiki/NVIDIA

{
  services.xserver.videoDrivers = [ "nvidia" ];

  environment.systemPackages = with pkgs; [
    vulkan-tools
  ];
  hardware = {
    # Opengl
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  hardware.nvidia = {
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    open = true;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      #offload.enable = true;
      sync.enable = true;
      # Correct the Bus ID values as per your system
      intelBusId = "PCI:0:2:0"; # Intel GPU Bus ID
      nvidiaBusId = "PCI:1:0:0"; # NVIDIA GPU Bus ID
    };
  };
}
