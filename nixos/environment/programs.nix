{ pkgs, ... }:
{
  programs = {
    git.enable = true;
    nano.enable = false;
    dconf.enable = true;
    zsh.enable = true;
    nix-ld.enable = true;
    mosh.enable = true;
    neovim.enable = true;
    steam = {
      enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      package = pkgs.steam.override {
        extraEnv = {
          __NV_PRIME_RENDER_OFFLOAD = true;
          __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        };
      };
    };
  };
}
