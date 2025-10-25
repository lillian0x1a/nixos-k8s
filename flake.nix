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
    nixosConfigurations.iso = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { hostname = "iso"; };
      modules = [
        "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
        ./hosts/configuration.nix
        {
          environment.systemPackages = with pkgs; [
            disko.packages.${system}.disko
          ];
        }
      ];
    };
    nixosConfigurations = {
      "${hostname}" = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit hostname; };
        modules = [
          disko.nixosModules.disko
          ./hosts/disko.nix
          ./hosts/configuration.nix
        ];
      };
    };
  };
}