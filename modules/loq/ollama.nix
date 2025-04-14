{ ... }:

{
  services.open-webui.enable = true;
  services.ollama = {
    enable = true;
    loadModels = [
      "phi3:mini-4k"
      "mistral"
    ];
    user = "incsix";
  };
}
