{ ... }:

{
  swapDevices = [
    {
      device = "/dev/nvme0n1p6";
      randomEncryption.enable = true;
    }
  ];
}
