{ pkgs, vscode-extensions, ... }:
{
  programs = {
    vscode = {
      enable = true;
      package = pkgs.vscodium;
      profiles.default = {
        extensions = with vscode-extensions.vscode-marketplace; [
          jnoortheen.nix-ide
          sdras.night-owl
          adpyke.codesnap
          saoudrizwan.claude-dev
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
          "codesnap.backgroundColor" = "#00000000";
          "codesnap.boxShadow" = "none";
          "codesnap.containerPadding" = "0";
          "codesnap.roundedCorners" = false;
          "codesnap.showWindowControls" = false;
          "codesnap.showWindowTitle" = false;
          "codesnap.showLineNumbers" = false;
          "codesnap.realLineNumbers" = false;
          "codesnap.transparentBackground" = true;
          "codesnap.target" = "window";
          "codesnap.shutterAction" = "save";
        };
      };
    };
  };
}
