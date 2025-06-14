{
  config,
  flakePath,
  pkgs,
  ...
}:
{
  programs = {
    helix = {
      enable = true;
      settings = {
        theme = "night_owl";
        editor = {
          cursor-shape = {
            normal = "block";
            insert = "bar";
            select = "underline";
          };
          lsp.display-messages = true;
          indent-guides = {
            render = true;
            character = "┆";
            skip-levels = 1;
          };
          soft-wrap = {
            enable = true;
            wrap-indicator = "↩ ";
          };
          whitespace = {
            render = {
              space = "all";
              tab = "all";
              newline = "none";
            };
            characters = {
              space = " ";
              nbsp = "⍽";
              tab = "→";
              newline = "⏎";
              tabpad = "·";
            };
          };
        };
      };
      languages = {
        language-server = with pkgs; {
          gopls = {
            command = "${gopls}/bin/gopls";
          };
          golangci-lint-langserver = {
            command = "${golangci-lint-langserver}/bin/golangci-lint-langserver";
          };
          nil = {
            command = "${nil}/bin/nil";
          };
          pyright = {
            command = "${pyright}/bin/pyright";
          };
          nixd = {
            command = "${nixd}/bin/nixd";
            options = {
              nixos = {
                expr = "(builtins.getFlake ${flakePath}).nixosConfigurations.teimoncloud.options";
              };
              home-manager = {
                expr = "(builtins.getFlake ${flakePath}).homeConfigurations.${config.home.username}.options";
              };
            };
          };
          vscode-json-language-server = {
            command = "${nodePackages.vscode-langservers-extracted}/bin/vscode-json-languageserver";
            args = [ "--stdio" ];
          };
          typescript-language-server = with pkgs; {
            command = "${nodePackages.typescript-language-server}/bin/typescript-language-server";
            args = [ "--stdio" ];
          };
          vscode-html-language-server = with pkgs; {
            command = "${nodePackages.vscode-langservers-extracted}/bin/vscode-html-language-server";
            args = [ "--stdio" ];
          };
          vscode-css-language-server = with pkgs; {
            command = "${nodePackages.vscode-langservers-extracted}/bin/vscode-css-language-server";
            args = [ "--stdio" ];
          };
          vscode-eslint-language-server = {
            command = "${nodePackages.eslint}/bin/eslint";
            args = [ "--stdio" ];
          };
          emmet-ls = {
            command = "${emmet-ls}/bin/emmet-ls";
            args = [ "--stdio" ];
          };
          zls = {
            command = "${zls}/bin/zls";
            args = [ "--stdio" ];
          };
        };
        language = with pkgs; [
          {
            name = "nix";
            auto-format = true;
            indent = {
              tab-width = 2;
              unit = "  ";
            };
            formatter.command = "${nixfmt-rfc-style}/bin/nixfmt";
            language-servers = [
              "nixd"
              "nil"
            ];
          }
          {
            name = "python";
            auto-format = false;
            indent = {
              tab-width = 4;
              unit = "    ";
            };
            formatter.command = "${ruff}/bin/ruff";
            language-servers = [
              "nixd"
              "nil"
            ];
          }
          {
            name = "go";
            auto-format = true;
            formatter.command = "${gotools}/bin/goimports";
            language-servers = [
              "gopls"
              "golangci-lint-langserver"
            ];
          }
          {
            name = "html";
            file-types = [
              "html"
              "htm"
            ];
            auto-format = false;
            formatter = {
              command = "${nodePackages.prettier}/bin/prettier";
              args = [
                "--parser"
                "html"
              ];
            };
            language-servers = [ "vscode-html-language-server" ];
          }
          {
            name = "json";
            formatter = {
              command = "${nodePackages.prettier}/bin/prettier";
              args = [
                "--parser"
                "json"
              ];
            };
            language-servers = [ "vscode-json-language-server" ];
          }
          {
            name = "css";
            formatter = {
              command = "${nodePackages.prettier}/bin/prettier";
              args = [
                "--parser"
                "css"
              ];
            };
            language-servers = [ "vscode-css-language-server" ];
          }
          {
            name = "javascript";
            file-types = [ "js" ];
            auto-format = true;
            formatter = {
              command = "${nodePackages.prettier}/bin/prettier";
              args = [
                "--parser"
                "typescript"
              ];
            };
            language-servers = [ "typescript-language-server" ];
          }
          {
            name = "typescript";
            file-types = [ "ts" ];
            auto-format = true;
            formatter = {
              command = "${nodePackages.prettier}/bin/prettier";
              args = [
                "--parser"
                "typescript"
              ];
            };
            language-servers = [ "typescript-language-server" ];
          }
          {
            name = "jsx";
            file-types = [ "jsx" ];
            auto-format = true;
            formatter = {
              command = "${nodePackages.prettier}/bin/prettier";
              args = [
                "--parser"
                "typescript"
              ];
            };
            language-servers = [
              "typescript-language-server"
              "vscode-eslint-language-server"
              "emmet-ls"
            ];
          }
          {
            name = "tsx";
            file-types = [ "tsx" ];
            auto-format = true;
            formatter = {
              command = "${nodePackages.prettier}/bin/prettier";
              args = [
                "--parser"
                "typescript"
              ];
            };
            language-servers = [
              "typescript-language-server"
              "vscode-eslint-language-server"
              "emmet-ls"
            ];
          }
          {
            name = "zig";
            file-types = [ "zig" ];
            auto-format = true;
            language-servers = [ "zls" ];
          }
        ];
      };
    };
  };
}
