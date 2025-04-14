{ ... }:

{
  services.ollama = {
    enable = true;
    loadModels = [
      "phi3:mini-4k"
    ];
    user = "incog267";
  };
}
