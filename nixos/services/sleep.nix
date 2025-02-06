{ ... }:
{
  systemd.sleep.extraConfig = ''
    HibernateDelaySec=10min
    SuspendState=mem
  '';

  services.logind = {
      lidSwitch = "ignore";
      lidSwitchExternalPower = "ignore";
      lidSwitchDocked = "ignore";
      suspendKey = "suspend";
      suspendKeyLongPress = "hibernate";
    };
}