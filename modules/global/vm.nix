{ pkgs, ... }:

{

  programs = {
    adb.enable = true;
    virt-manager.enable = true;
    virt-manager.package = pkgs.virt-manager;
  };

  services.spice-vdagentd.enable = true;
  services.qemuGuest.enable = true;

  virtualisation = {
    waydroid = {
      enable = true;
    };

    spiceUSBRedirection = {
      enable = true;
    };

    libvirtd = {
      enable = true;
      package = pkgs.libvirt;
      qemu = {
        swtpm = {
          enable = true;
        };
        ovmf = {
          enable = true;
        };
      };
    };
  };
}
