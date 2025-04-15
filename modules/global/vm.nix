{ pkgs-stable, ... }:

{

  programs = {
    virt-manager.enable = true;
    virt-manager.package = pkgs-stable.virt-manager;
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
      package = pkgs-stable.libvirt;
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
