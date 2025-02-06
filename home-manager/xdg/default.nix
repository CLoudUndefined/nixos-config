{ config, ... }:
{
  xdg = {
    userDirs = {
      enable = true;
      documents = "${config.home.homeDirectory}/Documents";
      download = "${config.home.homeDirectory}/Downloads";
      music = "${config.home.homeDirectory}/Music";
      pictures = "${config.home.homeDirectory}/Pictures";
      videos = "${config.home.homeDirectory}/Videos";
    };
    mimeApps = {
      defaultApplications = {
        "text/html" = "firefox.desktop";
        "application/xhtml+xml" = "firefox.desktop";
        "application/pdf" = "vlc.desktop";
        "text/plain" = "helix.desktop";

        "image/jpeg" = "qimgv.desktop";
        "image/png" = "qimgv.desktop";
        "image/gif" = "qimgv.desktop";

        "audio/mpeg" = "vlc.desktop";
        "audio/ogg" = "vlc.desktop";
        "video/mp4" = "vlc.desktop";
        "video/x-matroska" = "vlc.desktop";

        "application/zip" = "file-roller.desktop";
        "application/x-tar" = "file-roller.desktop";
        "application/x-rar-compressed" = "file-roller.desktop";

        "application/x-python" = "helix.desktop";
        "text/x-go" = "helix.desktop";
        "application/json" = "helix.desktop";
        "text/x-shellscript" = "helix.desktop";

        "application/x-bittorrent" = "qbittorrent.desktop";

        "text/markdown" = "obsidian.desktop";
      };
    };
  };
}
