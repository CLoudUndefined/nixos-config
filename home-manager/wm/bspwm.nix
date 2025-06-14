{ pkgs, ... }:

{
  xsession = {
    enable = true;
    windowManager.bspwm = {
      enable = true;
      monitors = {
        "eDP-1" = [
          "1.Web"
          "2.Chat"
          "3.Music"
          "4.Code"
          "5.Terminal"
          "6.Notes"
          "7.Games"
          "8.Misc"
          "9.Free"
        ];
      };

      rules = {
        "*:*:Picture-in-Picture" = {
          state = "floating";
        };
        "qimgv" = {
          state = "floating";
        };
      };

      settings = {
        border_width = 2;
        window_gap = 8;
        split_ratio = 0.52;
        borderless_monocle = true;
        gapless_monocle = true;
        focus_follows_pointer = false;
        pointer_follows_monitor = true;
        pointer_action1 = "move";
        pointer_action2 = "resize_side";
        pointer_action3 = "resize_side";

        normal_border_color = "#000000"; # #003f5c
        active_border_color = "#000000"; # #003f5c
        focused_border_color = "#FFFFFF"; # #ff6361
        presel_feedback_color = "#000000"; # #ffd380

        top_padding = 6;
        left_padding = 6;
        right_padding = 6;
        bottom_padding = 6;
      };

      startupPrograms = [
        "pkill -f rotate-wallpaper.sh; ~/.local/bin/rotate-wallpaper.sh"
        "pkill -f battery-notify.sh; ~/.local/bin/battery-notify.sh"
        "systemctl --user restart picom"
        "pkill -f udiskie; udiskie -t"
      ];
    };
  };
}
