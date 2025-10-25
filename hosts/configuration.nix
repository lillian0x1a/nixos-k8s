{config, pkgs, specialArgs, ...}:{
  imports = [];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  networking = {
    hostName = "${specialArgs.hostname}";
    firewall.allowedTCPPorts = [ 6443 9443 10250 ];
  };
  services.openssh = {
    enable = true;
    settings = {
      # permitRootLogin = "no";
      # passwordAuthentication = "no";
    };
  };
  environment.systemPackages = with pkgs; [
    neovim
    git
    jq
    curl
  ];
  security.sudo.wheelNeedsPassword = false;
  system.autoUpgrade.enable = false;
  system.stateVersion = "25.05";
}