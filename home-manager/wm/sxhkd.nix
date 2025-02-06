{ flakePath, ... }:

{
  services.sxhkd = {
    enable = true;
    extraConfig = builtins.readFile "${flakePath}/config/sxhkdrc";
  };
}
