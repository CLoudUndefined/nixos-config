{ pkgs, flakePath, ... }:

{
  services.polybar = {
    enable = true;
    package = pkgs.polybar;
    script = builtins.readFile "${flakePath}/config/polybar/launch.sh";
    extraConfig = builtins.readFile "${flakePath}/config/polybar/config.ini";
  };
}
