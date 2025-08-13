{ nix-flatpak, lib, pkgs-stable, ... }:

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
    pkgs-stable.lazydocker
  ];

  programs = {
    adb.enable = true;
    virt-manager = {
      enable = true;
      package = pkgs-stable.virt-manager;
    };
  };

  services.spice-vdagentd.enable = true;
  services.qemuGuest = {
    enable = true;
    package = pkgs-stable.qemu_kvm.ga;
  };

  virtualisation = {
    waydroid = {
      enable = true;
      package = pkgs-stable.waydroid;
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

  services.flatpak = {
    enable = true;
    remotes = lib.mkOptionDefault [{
      name = "flathub-beta";
      location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
    }];
    update.auto.enable = true;
  };
}
