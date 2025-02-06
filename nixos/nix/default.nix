{ ... }:
{
  nixpkgs.config.allowUnfree = true;

  nix = {
    settings = {
      auto-optimise-store = true;
      system-features = [
        "big-parallel"
        "nix-command"
        "flakes"
      ];
      cores = 0;
      substituters = [
        "https://cache.nixos.org/"
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-order-than 14d";
    };
  };
}
