{ ... }:
{
  imports = [
    ./alacritty.nix
    ./firefox.nix
    ./git.nix
    ./helix.nix
    ./polybar.nix
    ./rofi.nix
    ./vscode.nix
    ./zsh.nix
  ];

  programs = {
    btop = {
      enable = true;
      settings = {
        color_theme = "HotPurpleTrafficLight";
        truecolor = true;
        force_tty = false;
        update_ms = 1000;
      };
    };
  };
}