{
  description = "NixOS system configuration from Teiwo! :3";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    iwmenu.url = "github:e-tho/iwmenu";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs =
    {
      nixpkgs,
      disko,
      home-manager,
      iwmenu,
      nix-vscode-extensions,
      ...
    }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.teimoncloud = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          disks = [ "/dev/nvme0n1" ];
          flakePath = "/home/teiwo/nixos-configuration";
        };
        modules = [
          disko.nixosModules.disko
          {
            nixpkgs.overlays = [
              # Note: no longer needed package. Remains here as a memory (>_>)
              # (import ./packages/opengigabyte/overlay.nix)
              (import ./packages/gost3/overlay.nix)
              (import ./packages/sudo/overlay.nix)
            ];
          }
          ./nixos/configuration.nix
          ./nixos/boot/default.nix
          ./nixos/environment/default.nix
          ./nixos/hardware-gpu/default.nix
          ./nixos/misc/default.nix
          ./nixos/network/default.nix
          ./nixos/nix/default.nix
          ./nixos/security/default.nix
          ./nixos/services/default.nix
          ./nixos/users/default.nix

          # Note: no longer needed package. Remains here as a memory (>_>)
          # ./nixos/opengigabyte/default.nix
        ];
      };

      homeConfigurations.teiwo = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = {
          flakePath = "/home/teiwo/nixos-configuration";
          iwmenu-package = iwmenu.packages.${system}.default;
          vscode-extensions = nix-vscode-extensions.extensions.${system};
        };
        modules = [
          {
            nixpkgs.overlays = [
              # FIX: Update package.nix to install this package. Currently broken.
              # (import ./packages/rofi-kaomoji/overlay.nix)
              (import ./packages/renterd/overlay.nix)
            ];
          }
          ./home-manager/home.nix
        ];
      };
    };
}
