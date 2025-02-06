{ ... }:
{
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = [
        "DejaVu Serif"
        "Noto Serif CJK JP"
      ];
      sansSerif = [
        "DejaVu Sans"
        "Noto Sans CJK JP"
      ];
      monospace = [
        "DejaVu Sans Mono"
        "Noto Sans Mono CJK JP"
      ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
