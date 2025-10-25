{
  description = "A NixOS-based Kubernetes cluster with Disco";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    disco.url = "github:nix-community/disco";
  };
  outputs = { self, nixpkgs, disco, ... }:
    let
      system = "x86_64-linux";
      pkgs = import mixpkgs { inherit system; };
    in
  {
    nixosConfigurations = {
      node = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          disco.nixosModules.disco
          ./hosts/configuration.nix
        ];
      };
    };
    app.${system}.disco = {
      type = "app";
      program = "${disco.packages.${system}.disco}/bin/disco";
    };
  };
}