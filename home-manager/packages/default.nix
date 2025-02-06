{
  pkgs,
  iwmenu-package,
  ...
}:
{
  home.packages = with pkgs; [
    # Utilities
    dconf
    pywal16
    brightnessctl
    imagemagick
    file-roller
    direnv
    ollama-cuda
    fastfetch

    # Productivity
    obsidian
    nautilus
    spotify
    renterd

    # Program
    file-roller
    chromium
    vlc
    nekoray
    hiddify-app
    qimgv
    qbittorrent
    flameshot

    # Fonts
    nerd-fonts.jetbrains-mono
    monocraft
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    dejavu_fonts
    inter

    # Games
    prismlauncher

    # Communication
    telegram-desktop
    vesktop
    element-desktop

    iwmenu-package

    # ==|FIX|==
    # rofi-kaomoji
  ];
}
