{
  device = "/dev/sda";
  name = "disco-vm-disk";

  partitions = [
    {
      type = "efi";
      size = "512MiB"; 
      flags = [ "esp" ];
      fs = {
        type = "vfat";
        label = "EFI-SYSTEM";
      };
    }
    {
      type = "root";
      size = "100%";
      fs = {
        type = "btrfs";
        label = "ROOT-BTRFS";
      };
    }
  ];
}