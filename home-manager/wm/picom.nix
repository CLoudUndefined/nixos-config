{ ... }:
{
  services.picom = {
    enable = true;
    backend = "glx";
    vSync = false;

    shadow = true;
    shadowOpacity = 0.65;
    shadowOffsets = [
      (-15)
      (-15)
    ];
    shadowExclude = [
      "name = 'Notification'"
      "class_g = 'Polybar'"
      "_GTK_FRAME_EXTENTS@:c"
      "window_type = 'dock'"
      "window_type = 'menu'"
      "window_type = 'popup_menu'"
      "window_type = 'dropdown_menu'"
      "window_type = 'utility'"
    ];

    fade = true;
    # fadeSteps = [ 2.5e-2 2.5e-2 ];
    fadeSteps = [
      6.0e-2
      6.0e-2
    ];
    fadeDelta = 8;

    activeOpacity = 1.0;
    inactiveOpacity = 0.92;
    menuOpacity = 0.98;
    opacityRules = [
      "95:class_g = 'Alacritty'"
      "95:class_g = 'VSCodium'"
    ];

    settings = {
      transition-length = 150; # Умеренная длительность анимации переходов (в мс)
      size-transition = true;

      corner-radius = 12;
      rounded-corners-exclude = [
        "class_g = 'Polybar'"
        "class_g = 'Dunst'"
        "window_type = 'dock'"
      ];

      shadow-radius = 14;
      shadow-color = "#000000";
      frame-opacity = 0.98;

      blur-method = "dual_kawase";
      blur-strength = 2;
      blur-background = true;
      blur-background-exclude = [
        "window_type = 'dock'"
        "window_type = 'desktop'"
        "window_type = 'menu'"
        "window_type = 'popup_menu'"
        "window_type = 'dropdown_menu'"
        "class_g = 'Peek'"
        "_GTK_FRAME_EXTENTS@:c"
      ];

      mark-wmwin-focused = true;
      mark-ovredir-focused = true;
      detect-rounded-corners = true;
      detect-client-opacity = true;
      detect-transient = true;
      detect-client-leader = true;
      use-damage = true;
      log-level = "warn";
    };
  };
}
