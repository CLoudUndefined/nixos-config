{ pkgs, ... }:
{
  security = {
    wrappers.pingtunnel = {
      source = "${pkgs.pingtunnel}/bin/pingtunnel";
      capabilities = "cap_net_raw+ep";
      owner = "root";
      group = "root";
    };
    rtkit.enable = true;
    sudo = {
      enable = true;
      extraRules = [
        {
          users = [ "teiwo" ];
          commands = [
            {
              command = "/run/current-system/sw/bin/wg-quick";
              options = [ "NOPASSWD" ];
            }
          ];
        }
      ];
    };
  };
}
