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

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.93.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    iwmenu.url = "github:e-tho/iwmenu";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    prismlauncher.url = "github:PrismLauncher/PrismLauncher";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
  };

  outputs =
    {
      nixpkgs,
      disko,
      home-manager,
      lix-module,
      iwmenu,
      nix-vscode-extensions,
      zen-browser,
      prismlauncher,
      nix-flatpak,
      ...
    }:
    let
      system = "x86_64-linux";
      flakePath = "/home/teiwo/nixos-configuration";
    in
    {
      nixosConfigurations.teimoncloud = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          disks = [ "/dev/nvme0n1" ];
          inherit flakePath;
        };
        modules = [
          disko.nixosModules.disko
          lix-module.nixosModules.default
          {
            nixpkgs.overlays = [
              (import ./packages/gost3/overlay.nix)
              (import ./packages/sudo/overlay.nix)
            ];
          }
          ./modules/aiBlocker.nix
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
        ];
      };

      homeConfigurations.teiwo = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = {
          inherit flakePath;
          iwmenu-package = iwmenu.packages.${system}.default;
          vscode-extensions = nix-vscode-extensions.extensions.${system};
          zen-browser-package = zen-browser.packages.${system}.default;
          prismlauncher = prismlauncher.packages.${system}.prismlauncher;
        };
        modules = [
          nix-flatpak.homeManagerModules.nix-flatpak
          {
            nixpkgs.overlays = [
              (import ./packages/rofi-kaomoji/overlay.nix)
              (import ./packages/renterd/overlay.nix)
            ];
          }
          ./home-manager/home.nix
        ];
      };
    };
}
