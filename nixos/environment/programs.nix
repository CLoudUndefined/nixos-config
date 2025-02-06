{ pkgs, ... }:
{
  programs = {
    git.enable = true;
    dconf.enable = true;
    zsh.enable = true;
    nix-ld.enable = true;
    steam = {
      enable = true;
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
