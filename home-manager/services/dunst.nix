{ ... }:
{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        frame_color = "#89b4fa";
        font = "Inter 9";
        format = "<b>%s</b>\n%b";
        separator_color = "frame";
        highlight = "#89b4fa";
        offset = "14x46";
      };
      urgency_low = {
        background = "#1e1e1e";
        foreground = "#cdd6f4";
      };
      urgency_normal = {
        background = "#1e1e1e";
        foreground = "#cdd6f4";
      };
      urgency_critical = {
        background = "#1e1e1e";
        foreground = "#cdd6f4";
      };
    };
  };
}
