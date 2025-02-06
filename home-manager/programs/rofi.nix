{
  pkgs,
  flakePath,
  ...
}:
{
  programs.rofi = {
    enable = true;
    theme = "${flakePath}/config/rofi.rasi";
    terminal = "${pkgs.alacritty}/bin/alacritty";

    extraConfig = {
      modi = "drun";
      icon-theme = "Papirus";
      show-icons = true;
      hide-scrollbar = true;
      sidebar-mode = true;

      display-drun = "Apps";

      # Производительность и поведение
      sort = true;
      sorting-method = "fzf";
      case-sensitive = false;
      cycle = true;
      scroll-method = 1;

      # Клавиатурные сокращения
      kb-remove-to-eol = "Control+k";
      kb-accept-entry = "Return,KP_Enter";
      kb-row-up = "Up,Control+p";
      kb-row-down = "Down,Control+n";

      # Поиск и фильтрация
      matching = "fuzzy";
      tokenize = true;
      drun-display-format = "{name} [<span weight='light' size='small'><i>({generic})</i></span>]";

      # Производительность
      threads = 0;
      drun-cache-expiry = 60;
    };
  };
}
