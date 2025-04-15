{ nix-flatpak, lib, ... }:

{
  services.flatpak = {
    enable = true;
    remotes = lib.mkOptionDefault [
      {
        name = "flathub-beta";
        location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
      }
    ];
    packages = [
      "app.zen_browser.zen"
    ];
    update.auto.enable = true;
  };
}
