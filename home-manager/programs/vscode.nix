{ pkgs, vscode-extensions, ... }:
{
  programs = {
    vscode = {
      enable = true;
      package = pkgs.vscodium;
      extensions = with vscode-extensions.vscode-marketplace; [
        jnoortheen.nix-ide
        sdras.night-owl
        adpyke.codesnap
      ];
      userSettings = {
        "editor.fontFamily" = "JetBrainsMono NF";
        "editor.fontSize" = 14;
        "editor.fontLigatures" = true;
        "window.titleBarStyle" = "custom";
        "editor.minimap.enabled" = false;
        "workbench.colorTheme" = "Night Owl";
        "editor.stickyScroll.enabled" = false;
        "workbench.editor.enablePreview" = false;
        "explorer.confirmDelete" = false;
        "files.autoSave" = "afterDelay";
      };
    };
  };
}
