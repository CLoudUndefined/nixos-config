{ pkgs, ... }:
{
  services = {
    libinput.touchpad.naturalScrolling = true;
    displayManager = {
      defaultSession = "none+bspwm";
      ly = {
        enable = true;
        settings = {
          animation = "matrix";
          clock = "%c";
          clear_password = true;
          default_input = "password";
          vi_mode = true;
          xinitrc = "null";
        };
      };
    };
    xserver = {
      videoDrivers = [
        "nvidia"
      ];
      enable = true;
      autorun = false;
      xkb = {
        layout = "us,ru";
        options = "grp:switch,grp:caps_toggle";
      };
      windowManager.bspwm = {
        enable = true;
        configFile = builtins.getEnv "HOME" + "/.config/bspwm/bspwmrc";
        sxhkd.configFile = builtins.getEnv "HOME" + "/.config/sxhkd/sxhkdrc";
      };
      excludePackages = [ pkgs.xterm ];
      serverFlagsSection = ''
        Option "BlankTime" "0"
        Option "StandbyTime" "0"
        Option "SuspendTime" "0"
        Option "OffTime" "0"
      '';
    };
  };
}