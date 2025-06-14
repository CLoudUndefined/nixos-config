{ pkgs, ... }:

{
  services.polybar = {
    enable = true;
    package = pkgs.polybar;
    script = "polybar default &";
    settings = {
      "bar/default" = {
        width = "100%";
        height = "24pt";
        line-size = "3pt";
        radius = 0;
        padding-left = 0;
        padding-right = 1;
        module-margin = 0;

        border-top-size = "4pt";
        border-left-size = "12pt";
        border-right-size = "12pt";
        border-color = "#00000000";

        fixed-center = true;

        background = "\${xrdb:background:#00202e}";
        foreground = "\${xrdb:foreground:#ff6351}";

        modules-left = "bspwm xwindow eth wlan";
        modules-center = "date";
        modules-right = "alsa battery memory systray menu-actions";

        separator = " ; ";
        separator-foreground = "\${xrdb:color2:#003f5c}";

        font = [ "Monocraft:pixelsize=14;2" ];
        cursor-click = "pointer";
        cursor-scroll = "ns-resize";

        enable-ipc = true;
        wm-restack = "bspwm";
      };

      "module/bspwm" = {
        type = "internal/bspwm";
        pin-workspaces = true;

        label-focused = "%name%";
        label-focused-background = "\${xrdb:background:#003f5c}";
        label-focused-underline = "\${xrdb:color1:#2c4875}";
        label-focused-padding = 1;

        label-occupied = "";
        label-occupied-padding = 1;

        label-urgent = "%name%";
        label-urgent-background = "\${xrdb:color5:#ffd380}";
        label-urgent-padding = 1;

        label-empty = "";
        label-empty-padding = 1;
      };

      "module/xwindow" = {
        type = "internal/xwindow";
        label = "%class%";
        label-empty = "";
      };

      "module/memory" = {
        type = "internal/memory";
        interval = 2;
        label = "RAM %percentage_used%%";
      };

      "module/date" = {
        type = "internal/date";

        label = "%time%";

        time = "%I:%M %p";
        time-alt = "%d.%m.%y / %I:%M:%S %p";
      };

      "module/alsa" = {
        type = "internal/alsa";

        master-soundcard = "hw:1";
        speaker-soundcard = "hw:1";
        headphone-soundcard = "hw:1";

        master-mixer = "Master";
        speaker-mixer = "Speaker";

        mapped = true;
        interval = 5;

        format-volume = "<label-volume>";

        label-muted = "muted";
        label-muted-foreground = "#66";

        ramp-headphones = [
          "hp"
          "hp"
        ];

        label-volume = "vol %percentage%%";
      };

      "module/systray" = {
        type = "internal/tray";
        tray-size = "18pt";
      };

      "network-base" = {
        type = "internal/network";
        interval = 1;
        format-connected = "<label-connected>";
        format-disconnected = "<label-disconnected>";
        label-disconnected = "";
      };

      "module/wlan" = {
        "inherit" = "network-base";
        interface-type = "wireless";
        label-connected = "%essid%";
        label-connected-foreground = "\${xrdb:color14:#ffa600}";
      };

      "module/eth" = {
        "inherit" = "network-base";
        interface-type = "wired";
        label-connceted = "%local_ip%";
        label-connected-foreground = "\${xrdb:color14:#ffa600}";
      };

      "module/battery" = {
        "type" = "internal/battery";
        full-at = 95;
        low-at = 25;

        label-charging = "{▲%percentage%%}";
        label-discharging = "{▼%percentage%%}";
        label-full = "{full%}";
        label-low = "{!%percentage%%}";

        battery = "BAT1";
        adapter = "ADP1";
      };

      "module/menu-actions" = {
        type = "custom/menu";
        label-open = "Actions";
        label-close = "x";
        label-separator = " ; ";
        label-separator-foreground = "\${xrdb:color2:#003f5c}";

        menu-0-0 = "Reboot";
        menu-0-0-exec = "/run/current-system/sw/bin/systemctl reboot";
        menu-0-1 = "Power off";
        menu-0-1-exec = "/run/current-system/sw/bin/systemctl poweroff";
        menu-0-2 = "Logout...";
        menu-0-2-exec = "/run/current-system/sw/bin/bspc quit";
      };
    };
  };
}
