{ pkgs-stable, ... }:

{
  services.open-webui = {
    enable = true;
    package = pkgs-stable.open-webui;
  };
  services.ollama = {
    enable = true;
    package = pkgs-stable.ollama;
    loadModels = [
      "phi3:mini-4k"
      "mistral"
    ];
    user = "incsix";
  };
}
