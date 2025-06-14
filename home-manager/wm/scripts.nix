{ flakePath, ... }:
{
  home.file = {
    ".local/bin/apply-color-scheme.sh" = {
      executable = true;
      text = builtins.readFile "${flakePath}/src/scripts/apply-color-scheme.sh";
    };
    ".local/bin/rotate-wallpaper.sh" = {
      executable = true;
      text = builtins.readFile "${flakePath}/src/scripts/rotate-wallpaper.sh";
    };
    ".local/bin/toggle-polybar.sh" = {
      executable = true;
      text = builtins.readFile "${flakePath}/src/scripts/toggle-polybar.sh";
    };
    ".local/bin/battery-notify.sh" = {
      executable = true;
      text = builtins.readFile "${flakePath}/src/scripts/battery-notify.sh";
    };
    ".wallpapers" = {
      source = "${flakePath}/src/wallpapers";
      recursive = true;
    };
  };
}