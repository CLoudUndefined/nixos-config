{ pkgs, ... }:
{
  imports = [
    ./fonts/default.nix
    ./gtk/default.nix
    ./nix/default.nix
    ./packages/default.nix
    ./programs/default.nix
    ./services/default.nix
    ./wm/default.nix
    ./xdg/default.nix
  ];

  home = {
    username = "teiwo";
    homeDirectory = "/home/teiwo";
    stateVersion = "24.11";
    pointerCursor = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
      gtk.enable = true;
      x11.enable = true;
    };
    sessionVariables = {
      EDITOR = "hx";
    };
  };
}
