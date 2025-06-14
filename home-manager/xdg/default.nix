{ config, ... }:
{
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      documents = "${config.home.homeDirectory}/Documents";
      download = "${config.home.homeDirectory}/Downloads";
      music = "${config.home.homeDirectory}/Music";
      pictures = "${config.home.homeDirectory}/Pictures";
      videos = "${config.home.homeDirectory}/Videos";
    };
    mime.enable = true;
    mimeApps = {
      enable = true;
      associations = {
        added = {
          "inode/directory" = "org.gnome.Nautilus.desktop";
          "image/png" = "qimgv.desktop";
          "application/pdf" = "org.pwmt.zathura-pdf-mupdf.desktop";
          "application/x-zerosize" = "qimgv.desktop";
          "image/jpeg" = "qimgv.desktop";
          "application/toml" = "codium.desktop";
          "video/x-matroska" = "vlc.desktop";
          "video/mp4" = "vlc.desktop";
          "application/x-bittorrent" = "qbittorrent.desktop";
          "x-scheme-handler/magnet" = "qbittorrent.desktop";
          "text/plain" = "codium.desktop";
          "text/markdown" = "codium.desktop";
          "application/json" = "codium.desktop";
          "text/html" = "librewolf.desktop";
          "application/xhtml+xml" = "librewolf.desktop";
          "x-scheme-handler/http" = "librewolf.desktop";
          "x-scheme-handler/https" = "librewolf.desktop";
          "application/xml" = "codium.desktop";
          "application/yaml" = "codium.desktop";
          "application/x-yaml" = "codium.desktop";
        };
        removed = { };
      };
      defaultApplications = {
        "inode/directory" = "org.gnome.Nautilus.desktop";
        "image/png" = "qimgv.desktop";
        "application/pdf" = "org.pwmt.zathura-pdf-mupdf.desktop";
        "image/jpeg" = "qimgv.desktop";
        "x-scheme-handler/discord" = "vesktop.desktop";
        "application/toml" = "codium.desktop";
        "video/x-matroska" = "vlc.desktop";
        "video/mp4" = "vlc.desktop";
        "application/x-bittorrent" = "qbittorrent.desktop";
        "x-scheme-handler/magnet" = "qbittorrent.desktop";
        "text/plain" = "codium.desktop";
        "text/markdown" = "codium.desktop";
        "application/json" = "codium.desktop";
        "text/html" = "librewolf.desktop";
        "application/xhtml+xml" = "librewolf.desktop";
        "x-scheme-handler/http" = "librewolf.desktop";
        "x-scheme-handler/https" = "librewolf.desktop";
        "application/xml" = "codium.desktop";
        "application/yaml" = "codium.desktop";
        "application/x-yaml" = "codium.desktop";
        "x-scheme-handler/tg" = "telegram-desktop.desktop";
        "x-scheme-handler/element" = "element-desktop.desktop";
        "image/gif" = "qimgv.desktop";
        "image/webp" = "qimgv.desktop";
        "application/x-compressed-tar" = "file-roller.desktop";
        "application/zip" = "file-roller.desktop";
        "application/x-rar" = "file-roller.desktop";
        "application/gzip" = "file-roller.desktop";
        "application/x-7z-compressed" = "file-roller.desktop";
        "x-scheme-handler/obsidian" = "obsidian.desktop";
        "application/vnd.obsidian" = "obsidian.desktop";
        "x-scheme-handler/mailto" = "librewolf.desktop";
      };
    };
  };
}
