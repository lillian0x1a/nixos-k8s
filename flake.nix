{
  description = "A NixOS-based Kubernetes cluster with Disco";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    disko.url = "github:nix-community/disko";
  };
  outputs = { self, nixpkgs, disko, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      hostname = "node";
    in
  {
    nixosConfigurations = {
      "${hostname}" = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          disko.nixosModules.disko
          ./hosts/configuration.nix
        ];
      };
    };
    app.${system}.disko = {
      type = "app";
      program = "${disko.packages.${system}.disko}/bin/disko";
    };
  };
}