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
        "camera"
        "storage"
        "networkmanager"
        "wheel"
        "docker"
        "flatpak"
        "libvirtd"
        "kvm"
      ];
      shell = pkgs.zsh;
      hashedPassword = lib.strings.fileContents "${flakePath}/src/passwords/teiwoHashedPassword";
    };
  };
}
