{ pkgs, ... }:
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
            character = "┆"; # Some characters that work well: "▏", "┆", "┊", "⸽"
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
              nbsp = "⍽"; # Non Breaking SPace
              tab = "→";
              newline = "⏎";
              tabpad = "·";
            };
          };
        };
      };
      languages = {
        language-server = {
          gopls = with pkgs; {
            command = "${gopls}/bin/gopls";
          };
          golangci-lint-langserver = with pkgs; {
            command = "${golangci-lint-langserver}/bin/golangci-lint-langserver";
          };
          nil = with pkgs; {
            command = "${nil}/bin/nil";
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
        ];
      };
    };
  };
}
