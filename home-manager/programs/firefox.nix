{ pkgs, ... }:
let
  extensionsList = [
    {
      id = "uBlock0@raymondhill.net";
      name = "ublock-origin";
      url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
      sha256 = "sha256-ueHIaL0awd78q/LgF3bRqQ7/ujSwf+aiE1DUXwIuDp8=";
    }
    {
      id = "jid1-MnnxcxisBPnSXQ@jetpack";
      name = "privacy-badger";
      url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
      sha256 = "sha256-w7bAvySbayZh3Cn0FNOr4cDWN7TgWaSfQqAcxz8xmuo=";
    }
    {
      id = "idcac-pub@guus.ninja";
      name = "istilldontcareaboutcookies";
      url = "https://addons.mozilla.org/firefox/downloads/latest/istilldontcareaboutcookies/latest.xpi";
      sha256 = "sha256-yt6yRiLTuaK4K/QwgkL9gCVGsSa7ndFOHqZvKqIGZ5U=";
    }
    {
      id = "{036a55b4-5e72-4d05-a06c-cba2dfcc134a}";
      name = "translate-web-pages";
      url = "https://addons.mozilla.org/firefox/downloads/latest/traduzir-paginas-web/latest.xpi";
      sha256 = "sha256-3JSn76xjRo99NKdL7fXIs2CmfJnSE7tbGh1V2RF5d4I=";
    }
    {
      id = "{a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7}";
      name = "user-agent-switcher";
      url = "https://addons.mozilla.org/firefox/downloads/latest/user-agent-string-switcher/latest.xpi";
      sha256 = "sha256-ncjaPIxG1PBNEv14nGNQH6ai9QL4WbKGk5oJDbY+rjM=";
    }
    {
      id = "clipper@obsidian.md";
      name = "obsidian-web-clipper";
      url = "https://addons.mozilla.org/firefox/downloads/latest/web-clipper-obsidian/latest.xpi";
      sha256 = "sha256-fW15LU6Mq1We5wQdprmzmDsyVqKDxL85AzwB/kcC8vY=";
    }
    {
      id = "{531906d3-e22f-4a6c-a102-8057b88a1a63}";
      name = "single-file";
      url = "https://addons.mozilla.org/firefox/downloads/latest/single-file/latest.xpi";
      sha256 = "sha256-rMJ+4jGeZhkqgIHKt3Hs0emaDqBMKSYuWVpD3ckuBac=";
    }
    {
      id = "{acf99872-d701-4863-adc2-cdda1163aa34}";
      name = "time-shift";
      url = "https://addons.mozilla.org/firefox/downloads/latest/change-timezone-time-shift/latest.xpi";
      sha256 = "sha256-MJXw91qsfcrEXsFIx8iDaRA22owmhU5dLR23w9nekSw=";
    }
    {
      id = "@testpilot-containers";
      name = "multi-account-containers";
      url = "https://addons.mozilla.org/firefox/downloads/latest/multi-account-containers/latest.xpi";
      sha256 = "sha256-z3iI6cBXEyVupFekJQv22g5ITkn35lhwOtcjL4wTgjA=";
    }
  ];
in
{
  programs.firefox = {
    enable = true;

    policies = {
      ExtensionSettings =
        {
          "*" = {
            installation_mode = "blocked";
          };
        }
        // builtins.listToAttrs (
          builtins.map (extension: {
            name = extension.id;
            value = {
              install_url = extension.url;
              installation_mode = "force_installed";
            };
          }) extensionsList
        );
    };

    package = pkgs.librewolf;

    profiles."default" = {
      id = 0;
      name = "default";
      isDefault = true;
      settings = {
        "privacy.trackingprotection.enabled" = true;
        "privacy.donottrackheader.enabled" = true;
        "privacy.resistFingerprinting" = true;
        "privacy.firstparty.isolate" = true;
      };

      extraConfig = ''
        user_pref("extensions.pendingOperations", false);
        user_pref("extensions.activeThemeID", "default-theme@mozilla.org");
        user_pref("extensions.autoDisableScopes", 0);
        user_pref("extensions.enabledScopes", 15);
        user_pref("media.peerconnection.enabled", false);
        user_pref("browser.tabs.inTitlebar", 0);
      '';

      extensions.packages = builtins.map (
        extension:
        pkgs.fetchFirefoxAddon {
          name = extension.name;
          url = extension.url;
          sha256 = extension.sha256;
        }
      ) extensionsList;
    };
  };
}
