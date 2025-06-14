{ ... }:
{
  imports = [
    ./dunst.nix
  ];

  services = {
    cliphist.enable = true;
    flatpak = {
      enable = true;
      remotes = [
        {
          name = "flathub";
          location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
        }
      ];
      packages = [
        "com.usebottles.bottles"
      ];
      update.auto = {
        enable = false;
      };
      uninstallUnmanaged = true;
    };
  };
}
