{ ... }:
{
  imports = [
    ./fonts.nix
    ./packages.nix
    ./programs.nix
    ./virtualisation.nix
    ./xdg.nix
    ./zramswap.nix
  ];

  environment.variables.EDITOR = "nvim";
}
