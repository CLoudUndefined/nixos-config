{ ... }:
{
  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = true;
    fontconfig = {
      allowBitmaps = false;
      hinting = {
        enable = true;
        style = "full";
      };
      antialias = true;
      subpixel.rgba = "rgb";
    };
  };
}
