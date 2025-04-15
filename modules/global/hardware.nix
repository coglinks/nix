{...}:

{
  # Prevents suspend of mouse after a few seconds
  # You might be able to use `usbcore.autosuspend=-1` to disable entirely
  # ref = https://discourse.nixos.org/t/turn-off-autosuspend-for-usb/58933
  boot.kernelParams = [ 
    "usbcore.autosuspend=-1" 
  ]; # if autosuspend=120 => wait for 2 minutes. 
}
