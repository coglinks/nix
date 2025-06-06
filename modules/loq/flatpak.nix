{ nix-flatpak, lib, ... }:

{
  services.flatpak = {
    enable = true;
    remotes = lib.mkOptionDefault [{
      name = "flathub-beta";
      location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
    }];
    packages = [
      "io.itch.itch"
    ];
    update.auto.enable = true;
  };
}
