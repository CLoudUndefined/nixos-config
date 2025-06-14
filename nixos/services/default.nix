{ ... }:
{
  imports = [
    ./sleep.nix
    ./tlp.nix
    ./xorg.nix
  ];

  services = {
    dbus.enable = true;
    psd.enable = true;
    udisks2.enable = true;
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      jack.enable = true;
    };
    flatpak.enable = true;
  };
}
