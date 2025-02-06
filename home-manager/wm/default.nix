{ pkgs, ... }:

{
  imports = [
    ./bspwm.nix
    ./sxhkd.nix
    ./picom.nix
    ./polybar.nix
  ];

  # For WM and desktop
  home.packages = with pkgs; [
    feh
    rofi
    libnotify
  ];
}
