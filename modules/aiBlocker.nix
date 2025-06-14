{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.services.aiBlocker;

  commonFlush = ''
    flush_dns_cache() {
      if [ -x "${pkgs.systemd}/bin/systemd-resolve" ]; then
        ${pkgs.systemd}/bin/systemd-resolve --flush-caches >/dev/null 2>&1 || true
      elif [ -x "${pkgs.coreutils}/bin/service" ]; then
        ${pkgs.coreutils}/bin/service nscd restart >/dev/null 2>&1 || true
        ${pkgs.coreutils}/bin/service dnsmasq restart >/dev/null 2>&1 || true
      fi
      echo "Note: You may need to restart browsers to clear their DNS cache"
    }
  '';

  requireRoot = ''
    if [ "$(${pkgs.coreutils}/bin/id -u)" -ne 0 ]; then
      echo "Error: Root privileges required. Run with sudo or as root."
      exit 1
    fi
  '';

  hostScript = ''
    ${requireRoot}
    ${commonFlush}

    enable_blocker() {
      echo "AI tools blocking is managed via NixOS networking.extraHosts."
      echo "To enable, set 'services.aiBlocker.enable = true' and apply the configuration."
      flush_dns_cache
    }
    disable_blocker() {
      echo "AI tools blocking is managed via NixOS networking.extraHosts."
      echo "To disable, set 'services.aiBlocker.enable = false' and apply the configuration."
      flush_dns_cache
    }
    status_blocker() {
      echo "AI tools blocking is managed via NixOS networking.extraHosts."
      echo "Check 'services.aiBlocker.enable' in your configuration to determine status."
    }
    case "$1" in
      enable) enable_blocker ;;
      disable) disable_blocker ;;
      status) status_blocker ;;
      *)
        echo "Usage: ai-blocker-host [enable|disable|status]"
        echo ""
        echo "  enable  - print instructions for enabling via NixOS"
        echo "  disable - print instructions for disabling via NixOS"
        echo "  status  - print status information"
        exit 1 ;;
    esac
  '';

  hostPackage = pkgs.writeShellApplication {
    name = "ai-blocker-host";
    runtimeInputs = [
      pkgs.bash
      pkgs.coreutils
    ];
    text = hostScript;
  };

  nftablesScript = pkgs.writeShellScript "update-nftables.sh" ''
    #!/usr/bin/env bash
    TABLE_NAME="ai_blocker"
    enable_nftables() {
      ${pkgs.nftables}/bin/nft add table inet "$TABLE_NAME" 2>/dev/null || true
      ${pkgs.nftables}/bin/nft add chain inet "$TABLE_NAME" output { type filter hook output priority 0 \; } 2>/dev/null || true
      ${concatStringsSep "\n" (
        map (domain: ''
          ips_v4=$(${pkgs.dnsutils}/bin/dig +short A "${domain}")
          for ip in $ips_v4; do
            ${pkgs.nftables}/bin/nft add rule inet "$TABLE_NAME" output ip daddr "$ip" counter reject
          done
          ips_v6=$(${pkgs.dnsutils}/bin/dig +short AAAA "${domain}")
          for ip in $ips_v6; do
            ${pkgs.nftables}/bin/nft add rule inet "$TABLE_NAME" output ip6 daddr "$ip" counter reject
          done
        '') cfg.domains
      )}
    }
    disable_nftables() {
      ${pkgs.nftables}/bin/nft delete table inet "$TABLE_NAME" 2>/dev/null || true
    }
    case "$1" in
      enable) enable_nftables ;;
      disable) disable_nftables ;;
      *) echo "Usage: $0 [enable|disable]"; exit 1 ;;
    esac
  '';

  scriptsDir = pkgs.runCommand "ai-blocker-scripts" { } ''
    mkdir -p $out
    cp ${nftablesScript} $out/update-nftables.sh
    chmod +x $out/update-nftables.sh
  '';

  firewallScript = ''
    ${requireRoot}
    ${commonFlush}

    TABLE_NAME="ai_blocker"
    SCRIPTS_DIR="${scriptsDir}"
    enable_blocker() {
      echo "Activating AI tools blocking via nftables..."
      "$SCRIPTS_DIR/update-nftables.sh" enable
      flush_dns_cache
      echo "AI tools blocking activated"
    }
    disable_blocker() {
      echo "Deactivating AI tools blocking via nftables..."
      "$SCRIPTS_DIR/update-nftables.sh" disable
      flush_dns_cache
      echo "AI tools blocking deactivated"
    }
    status_blocker() {
      echo "Checking AI tools blocking status..."
      if ${pkgs.nftables}/bin/nft list table inet "$TABLE_NAME" >/dev/null 2>&1; then
        echo "nftables rules (IPv4/IPv6): ACTIVE"
      else
        echo "nftables rules (IPv4/IPv6): INACTIVE"
      fi
    }
    case "$1" in
      enable) enable_blocker ;;
      disable) disable_blocker ;;
      status) status_blocker ;;
      *)
        echo "Usage: ai-blocker-firewall [enable|disable|status]"
        echo ""
        echo "  enable  - activate AI tools blocking via nftables"
        echo "  disable - deactivate AI tools blocking via nftables"
        echo "  status  - check blocking status"
        exit 1 ;;
    esac
  '';

  firewallPackage = pkgs.writeShellApplication {
    name = "ai-blocker-firewall";
    runtimeInputs = [
      pkgs.bash
      pkgs.coreutils
      pkgs.gnugrep
      pkgs.gawk
      pkgs.nftables
      pkgs.dnsutils
    ];
    text = firewallScript;
  };

  aiBlockerOverlay = self: super: {
    ai-blocker = {
      host = hostPackage;
      firewall = firewallPackage;
      default = hostPackage;
    };
  };

in
{
  options.services.aiBlocker = {
    enable = mkEnableOption "AI online tools blocker";
    package = mkOption {
      type = types.package;
      default = pkgs.ai-blocker.default;
      defaultText = literalExpression "pkgs.ai-blocker.default";
      description = "The ai-blocker package variant to use: 'host' for extraHosts, 'firewall' for nftables.";
    };
    domains = mkOption {
      type = types.listOf types.str;
      default = [
        "chatgpt.com"
        "claude.ai"
        "gemini.google.com"
        "grok.com"
        "perplexity.ai"
        "poe.com"
        "huggingface.co"
      ];
      description = "List of domains to block";
    };
    redirectTo = mkOption {
      type = types.str;
      default = "0.0.0.0";
      description = "IP address to redirect blocked domains (used only with 'host' package)";
    };
  };

  config = mkIf cfg.enable {
    nixpkgs.overlays = [ aiBlockerOverlay ];
    environment.systemPackages = [ cfg.package ];
    networking.extraHosts = mkIf (cfg.package == pkgs.ai-blocker.host) ''
      # BEGIN AI-BLOCKER
      # Managed by aiBlocker - ${builtins.toString builtins.currentTime}
      ${concatStringsSep "\n" (map (domain: "${cfg.redirectTo} ${domain}") cfg.domains)}
      # END AI-BLOCKER
    '';
    networking.firewall.extraPackages = mkIf (cfg.package == pkgs.ai-blocker.firewall) [
      pkgs.nftables
      pkgs.dnsutils
    ];
  };
}
