{ ... }:
{
  zramSwap = {
    enable = true;
    algorithm = "lz4";
    memoryPercent = 25;
  };
}
