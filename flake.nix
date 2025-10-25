{
  description = "A NixOS-based Kubernetes cluster with Disco";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    disco.url = "github:nix-community/disco";
  };
  outputs = { self, nixpkgs, disco, ... }: {
    nixosConfigurations = {
      control-plane = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          disco.nixosModules.disco
          ./hosts/control-plane/configuration.nix
        ];
      };
    };
  };
}