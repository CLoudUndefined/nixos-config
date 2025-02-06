{ ... }:
{
  imports = [
    ./alacritty.nix
    ./firefox.nix
    ./git.nix
    ./helix.nix
    ./rofi.nix
    ./vscode.nix
    ./zsh.nix
  ];

  programs = {
    btop.enable = true;
  };
}