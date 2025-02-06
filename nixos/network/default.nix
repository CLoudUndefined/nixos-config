{ pkgs, ... }:
{
  systemd = {
    network = {
      networks."25-wireless" = {
        matchConfig = {
          Type = "wlan";
        };
        networkConfig = {
          DHCP = "yes";
          IPv6PrivacyExtensions = "yes";
          IPv6AcceptRA = "yes";
        };
      };
      links."70-wifi" = {
        matchConfig = {
          Type = "wlan";
        };
        linkConfig = {
          MACAddressPolicy = "random";
        };
      };
    };
    services = {
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

  networking = {
    hostName = "teimoncloud";
    wireless.iwd = {
      enable = true;
      settings = {
        General = {
          EnableNetworkConfiguration = true;
          AddressRandomization = "network";
          AddressRandomizationRange = "full";
        };
        Network = {
          NameResolvingService = "resolvconf";
        };
      };
    };
    useNetworkd = true;
    useDHCP = true;
    firewall.enable = false;
    resolvconf.enable = false;
    nameservers = [
      "127.0.0.1"
    ];
  };

  services.unbound = {
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
}
