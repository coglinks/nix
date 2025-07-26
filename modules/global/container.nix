{ nix-flatpak, lib, pkgs, ... }:

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

  services.flatpak = {
    enable = true;
    remotes = lib.mkOptionDefault [{
      name = "flathub-beta";
      location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
    }];
    update.auto.enable = true;
  };
}
