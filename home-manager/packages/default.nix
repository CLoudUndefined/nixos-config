{
  pkgs,
  iwmenu-package,
  zen-browser-package,
  prismlauncher,
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
    aichat
    fastfetch
    translate-shell
    hugo
    shared-mime-info
    desktop-file-utils
    ffmpeg-full
    sqlcmd
    walk
    libsForQt5.xp-pen-deco-01-v2-driver

    # Productivity
    obsidian
    nautilus
    spotify
    renterd
    fluent-reader
    libreoffice-qt6-fresh

    # Program
    file-roller
    chromium
    vlc
    nekoray
    hiddify-app
    qimgv
    qbittorrent
    flameshot
    peek
    zathura
    zen-browser-package
    prismlauncher
    dbeaver-bin
    code-cursor
    filezilla

    # Fonts
    nerd-fonts.jetbrains-mono
    monocraft
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    dejavu_fonts
    inter
    corefonts
    vistafonts

    # Communication
    telegram-desktop
    vesktop
    element-desktop

    iwmenu-package

    rofi-kaomoji
    unityhub
  ];
}
