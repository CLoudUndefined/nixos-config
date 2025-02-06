{
  lib,
  pkgs,
  flakePath,
  ...
}:
{
  users = {
    defaultUserShell = pkgs.bash;
    users.teiwo = {
      isNormalUser = true;
      extraGroups = [
        "input"
        "audio"
        "video"
        "storage"
        "networkmanager"
        "wheel"
        "docker"
      ];
      shell = pkgs.zsh;
      hashedPassword = lib.strings.fileContents "${flakePath}/src/passwords/teiwoHashedPassword";
    };
  };
}
