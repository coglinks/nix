{ ... }:

{
  # The following convert the laptop's co-pilot key into a normal right control key
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "048d:c996:20fedd66" ];
        settings = {
          main = {
            "leftshift+leftmeta+f23" = "rightcontrol";
          };
          otherlayer = {};
        };
      };
    };
  };
}
