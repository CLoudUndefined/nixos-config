{
  lib,
  pkgs,
  ...
}:
{
  environment.etc."resolv.conf" = {
    mode = "0444";
    source = lib.mkForce (
      pkgs.writeText "resolv.conf" ''
        nameserver 127.0.0.1
        options edns0
      ''
    );
  };

  networking = {
    hostName = "teimoncloud";
    wireless.iwd = {
      enable = true;
      settings = {
        General = {
          EnableNetworkConfiguration = false;
          AddressRandomization = "network";
          AddressRandomizationRange = "full";
        };
        Network = {
          NameResolvingService = "systemd";
        };
      };
    };
    stevenblack = {
      enable = true;
      block = [
        "fakenews"
        "gambling"
      ];
    };
    useNetworkd = true;
    useDHCP = false;
    firewall.enable = false;
    resolvconf.enable = false;
    nameservers = [
      "127.0.0.1"
    ];
  };

  services = {
    aiBlocker = {
      enable = true;
      package = pkgs.ai-blocker.firewall;
    };
    unbound = {
      enable = true;
      settings = {
        server = {
          interface = [ "127.0.0.1" ];
          access-control = [ "127.0.0.0/8 allow" ];
          do-ip4 = true;
          do-ip6 = true;
          do-udp = true;
          do-tcp = true;
          auto-trust-anchor-file = "/var/lib/unbound/root.key";
          root-hints = "/var/lib/unbound/root.hints";
          prefetch = true;
          prefetch-key = true;
          cache-min-ttl = 3600;
          cache-max-ttl = 86400;
          num-threads = 4;
          msg-cache-size = "64m";
          rrset-cache-size = "128m";
        };
      };
    };
  };

  systemd = {
    network = {
      wait-online.enable = false;
      networks = {
        "25-wireless" = {
          matchConfig = {
            Type = "wlan";
          };
          networkConfig = {
            DHCP = "ipv4";
            IPv6PrivacyExtensions = "yes";
            IPv6AcceptRA = "yes";
          };
          dhcpV4Config = {
            UseDNS = false;
          };
          dhcpV6Config = {
            UseDNS = false;
          };
        };
      };
    };
    services = {
      systemd-resolved = {
        enable = false;
      };
      unbound = {
        preStart = ''
          mkdir -p /var/lib/unbound

          if ${pkgs.wget}/bin/wget -q -O "/var/lib/unbound/root.hints.tmp" "https://www.internic.net/domain/named.root"; then
            if ! ${pkgs.diffutils}/bin/cmp -s "/var/lib/unbound/root.hints.tmp" "/var/lib/unbound/root.hints"; then
              mv "/var/lib/unbound/root.hints.tmp" "/var/lib/unbound/root.hints"
              echo "Updated root.hints"
            else
              rm -f "/var/lib/unbound/root.hints.tmp"
              echo "No changes in root.hints"
            fi
          else
            echo "Failed to download root.hints, using existing version"
            rm -f "/var/lib/unbound/root.hints.tmp"
          fi
        '';
      };
    };
  };
}
