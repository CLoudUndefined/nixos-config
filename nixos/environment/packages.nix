{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      home-manager
      wget
      tree
      file
      vulkan-tools
      wireguard-tools
      pingtunnel
      sing-box
      udiskie
      bind
      psmisc
      alsa-utils
      gost3
      wineWowPackages.stable
      winetricks
      tmux
      pwgen
      lsof
      v4l-utils
      glib # For hiddify work
      qemu
      (pkgs.writeShellScriptBin "qemu-system-x86_64-uefi" ''
        qemu-system-x86_64 \
          -bios ${pkgs.OVMF.fd}/FV/OVMF.fd \
          "$@"
      '')
      virt-manager
      umu-launcher
      protonup-qt
      steamtinkerlaunch
    ];
  };
}
