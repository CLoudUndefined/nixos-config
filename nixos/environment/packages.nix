{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      home-manager
      neovim
      wget
      tree
      file
      vulkan-tools
      mesa
      wireguard-tools
      pingtunnel
      sing-box
      udiskie
      bind
      psmisc
      alsa-utils
      gost3

      glib # For hiddify work

      qemu
      (pkgs.writeShellScriptBin "qemu-system-x86_64-uefi" ''
        qemu-system-x86_64 \
          -bios ${pkgs.OVMF.fd}/FV/OVMF.fd \
          "$@"
      '')
    ];
  };
}
