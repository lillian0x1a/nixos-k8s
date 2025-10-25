{config, pkgs, ...}:{
  imports = [];
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  networking = {
    hostName = "node";
    firewall.allowedTCPPorts = [ 6443 9443 10250 ];
  };
  fileSystems."/" = {
    device = "LABEL=ROOT-BTRFS";
    fsType = "btrfs";
    options = [ "rw" "noatime" "compress=zstd:3" "space_cache=v2" "autodefrag" ];
  };
  fileSystems."/boot" = {
    device = "LABEL=EFI-SYSTEM";
    fsType = "vfat";
    options = [ "defaults" ];
  };
  services.openssh = {
    enable = true;
    permitRootLogin = "prohibit-password";
    passwordAuthentication = false;
  };
  environment.systemPackages = with pkgs; [
    vim
    git
    jq
    curl
  ];
  security.sudo.wheelNeedsPassword = false;
  system.autoUpgrade.enable = false;
}