{ pkgs, ... }:

{
  imports = [
    ./bspwm.nix
    ./scripts.nix
    ./sxhkd.nix
    ./picom.nix
  ];

  home.packages = with pkgs; [
    feh
    libnotify
  ];
}
