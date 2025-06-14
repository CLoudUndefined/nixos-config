{
  config,
  pkgs,
  ...
}:
let
  inherit (config.lib.formats.rasi) mkLiteral;
in
{
  programs.rofi = {
    enable = true;
    theme = {
      "*" = {
        font = "JetBrainsMono Nerd Font 12";
        bg0 = mkLiteral "#00202eE6";
        bg1 = mkLiteral "#003f5c80";
        bg2 = mkLiteral "#ff6361E6";
        fg0 = mkLiteral "#ffd380";
        fg1 = mkLiteral "#ffffff";
        fg2 = mkLiteral "#ffd38080";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@fg0";
        margin = 0;
        padding = 0;
        spacing = 0;
      };

      "window" = {
        background-color = mkLiteral "@bg0";
        location = mkLiteral "center";
        width = 640;
        border-radius = mkLiteral "10px";
      };

      "inputbar" = {
        font = "JetBrainsMono Nerd Font 14";
        padding = mkLiteral "14px";
        spacing = mkLiteral "10px";
        children = map mkLiteral [
          "icon-search"
          "entry"
        ];
      };

      "icon-search" = {
        expand = false;
        filename = "search";
        size = mkLiteral "28px";
      };

      "icon-search, entry, element-icon, element-text" = {
        vertical-align = "0.5";
      };

      "entry" = {
        font = mkLiteral "inherit";
        placeholder = "Search";
        placeholder-color = mkLiteral "@fg2";
      };

      "message" = {
        border = mkLiteral "2px 0 0";
        border-color = mkLiteral "@bg1";
        background-color = mkLiteral "@bg1";
      };

      "textbox" = {
        padding = mkLiteral "10px 24px";
      };

      "listview" = {
        lines = 10;
        columns = 1;
        fixed-height = false;
        border = mkLiteral "1px 0 0";
        border-color = mkLiteral "@bg1";
      };

      "element" = {
        padding = mkLiteral "10px 18px";
        spacing = mkLiteral "18px";
        background-color = mkLiteral "transparent";
      };

      "element normal active, element alternate active" = {
        text-color = mkLiteral "@bg2";
      };

      "element selected normal, element selected active" = {
        background-color = mkLiteral "#2c4875";
        text-color = mkLiteral "@fg1";
      };

      "element-icon" = {
        size = mkLiteral "1em";
      };
      "element-text" = {
        text-color = mkLiteral "inherit";
      };
    };
    terminal = "${pkgs.alacritty}/bin/alacritty";

    extraConfig = {
      modi = "drun";
      icon-theme = "Papirus";
      show-icons = true;
      hide-scrollbar = true;
      sidebar-mode = true;

      display-drun = "Apps";

      sort = true;
      sorting-method = "fzf";
      case-sensitive = false;
      cycle = true;
      scroll-method = 1;

      kb-remove-to-eol = "Control+k";
      kb-accept-entry = "Return,KP_Enter";
      kb-row-up = "Up,Control+p";
      kb-row-down = "Down,Control+n";

      matching = "fuzzy";
      tokenize = true;
      drun-display-format = "{name} [<span weight='light' size='small'><i>({generic})</i></span>]";

      threads = 0;
      drun-cache-expiry = 60;
    };
  };
}
