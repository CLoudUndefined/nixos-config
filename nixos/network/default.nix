{
  lib,
  pkgs,
  flakePath,
  ...
}:
{
  environment.etc."resolv.conf" = {
    mode = "0444";
    source = lib.mkForce (
      pkgs.writeText "resolv.conf" ''
        # Static resolv.conf pointing to local unbound
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

  services.zapret = {
    enable = false; # Включаем сервис Zapret

    params = [
      "--filter-udp=50000-50100 --filter-l7=discord,stun --dpi-desync=fake --new"
      "--filter-udp=53-65535 --filter-l7=wireguard --dpi-desync=fake --dpi-desync-repeats=11 --dpi-desync-fake-unknown-udp=/opt/zapret/files/fake/wireguard_initiation.bin --new"
      "--filter-udp=443 --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-quic=/opt/zapret/files/fake/quic_initial_www_google_com.bin --new"
      "--filter-tcp=80  --dpi-desync=fake,split2 --dpi-desync-autottl=2 --dpi-desync-fooling=md5sig --new"
      "--filter-tcp=443  --dpi-desync=split2 --dpi-desync-split-seqovl=652 --dpi-desync-split-pos=2 --dpi-desync-split-seqovl-pattern=/opt/zapret/files/fake/tls_clienthello_www_google_com.bin"
    ];

    whitelist = [
      "googlevideo.com"
      "googleusercontent.com" # Объединено из двух записей
      "youtubei.googleapis.com"
      "youtubeembeddedplayer.googleapis.com"
      "ytimg.l.google.com"
      "ytimg.com"
      "jnn-pa.googleapis.com"
      "youtube-nocookie.com"
      "youtube-ui.l.google.com"
      "yt-video-upload.l.google.com"
      "wide-youtube.l.google.com"
      "youtubekids.com"
      "ggpht.com"
      "discord.com"
      "gateway.discord.gg"
      "cdn.discordapp.com"
      "discordapp.net"
      "discordapp.com"
      "discord.gg"
      "media.discordapp.net"
      "images-ext-1.discordapp.net"
      "discord.app"
      "discord.media"
      "discordcdn.com"
      "discord.dev"
      "discord.new"
      "discord.gift"
      "discordstatus.com"
      "dis.gd"
      "discord.co"
      "discord-attachments-uploads-prd.storage.googleapis.com"
      "7tv.app"
      "7tv.io"
      "10tv.app"
      "cloudflare-ech.com"
      "frankerfacez.com"
      "betterttv.net"
      "cdn.betterttv.net"
    ];

    udpSupport = true;
    udpPorts = [
      "443"
      "50000:65535"
    ];

  };
}
