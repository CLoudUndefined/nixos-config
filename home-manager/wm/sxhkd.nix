{ ... }:

{
  services.sxhkd = {
    enable = true;
    keybindings = {
      "super + Return" = "alacritty";

      "super + shift + alt + r" = "bspc wm -r";

      "super + shift + Escape" = "pkill -USR1 -x sxhkd";

      "super + shift + alt + q" = "bspc quit";

      "super + d" = "rofi -show drun";

      "super + {h,j,k,l}" = "bspc node -f {west,south,north,east}";

      "super + shift + {h,j,k,l}" = "bspc node -s {west,south,north,east}";

      "super + ctrl + {h,j,k,l}" =
        "bspc node -z {left -20 0 || bspc node -z right -20 0,bottom 0 20 || bspc mode -z top 0 20,top 0 -20 || bspc node -z bottom 0 -20,right 20 0 || bspc node -z left 20 0}";

      "super + {Left,Down,Up,Right}" = "bspc node -f {west,south,north,east}";

      "super + shift + {Left,Down,Up,Right}" = "bspc node -s {west,south,north,east}";

      "super + f" = "bspc node -t '~fullscreen'";

      "super + shift + f" = "bspc node -t '~floating'";

      "super + ctrl + {Left,Down,Up,Right}" =
        "bspc node -z {left -20 0 || bspc node -z right -20 0,bottom 0 20 || bspc mode -z top 0 20,top 0 -20 || bspc node -z bottom 0 -20,right 20 0 || bspc node -z left 20 0}";

      "super + {1-9}" = "bspc desktop -f ^{1-9}";

      "super + shift + {1-9}" = "bspc node -d ^{1-9}";

      "super + Tab" = "bspc desktop -f next";

      "super + shift + Tab" = "bspc desktop -f prev";

      "super + alt + Tab" = "bspc node -d next";

      "super + shift + alt + Tab" = "bspc node -d prev";

      "super + grave" = "bspc node -f @last.active.window";

      "super + shift + q" = "bspc node -c";

      "super + e" = "nautilus";

      "super + o" = "rofi-kaomoji";

      "super + w" = "iwmenu --menu rofi";

      "super + F3" = "brightnessctl set 10%-";

      "super + F4" = "brightnessctl set +10%";

      "super + F7" = "amixer set Master toggle";

      "super + F8" = "amixer set Master 5%- unmute";

      "super + F9" = "amixer set Master 5%+ unmute";

      "super + shift + s" = "flameshot gui";

      "super + p" = "~/.local/bin/toggle-polybar.sh";
    };
  };
}
