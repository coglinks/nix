 { pkgs, lib, ... }:

 {
  boot.loader.efi.canTouchEfiVariables = true;
}
