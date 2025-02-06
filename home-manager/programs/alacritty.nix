{ ... }:
{
  programs = {
    alacritty = {
      enable = true;
      settings = {
        general = {
          import = [
            "~/.cache/wal/colors-alacritty.toml"
          ];
        };
        font = {
          size = 8;
          offset = {
            x = 0;
            y = 0;
          };
          normal.family = "JetBrainsMono Nerd Font Mono";
          normal.style = "Regular";
        };
        window = {
          padding = {
            x = 12;
            y = 12;
          };
        };
      };
    };
  };
}
