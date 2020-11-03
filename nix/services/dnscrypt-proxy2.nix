super:

let
  noTrackingBlacklist = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/notracking/hosts-blocklists/de5de6c24ad8fa1edfe6387d666acff21869083f/dnscrypt-proxy/dnscrypt-proxy.blacklist.txt";
    sha256 = "0gbpxa1x2yc8yffaj0xzq1brwhg1m9s389av7r8r6c5d4j9hsl9c";
  };
in {
  services.dnscrypt-proxy2 = {
    enable = true;

    settings = {
      server_names = [ "cloudflare-security" ];
      listen_addresses = [ "127.0.0.1:53" ];
      max_clients = 64;

      ipv4_servers = true;
      ipv6_servers = false;
      block_ipv6 = true;
      dnscrypt_servers = true;
      doh_servers = true;
      require_dnssec = true;
      require_nolog = true;
      require_nofilter = false;

      force_tcp = false;
      lb_strategy = "fastest";
      fallback_resolver = "8.8.8.8:53";
      ignore_system_dns = true;

      cache = true;
      cache_size = 8196;
      cache_min_ttl = 2400;
      cache_max_ttl = 86400;
      cache_neg_min_ttl = 60;
      cache_neg_max_ttl = 600;

      blacklist.blacklist_file = "${noTrackingBlacklist}";

      sources.public-resolvers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v2/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v2/public-resolvers.md"
        ];
        cache_file = "public-resolvers.md";
        minisign_key =
          "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
        refresh_delay = 72;
        prefix = "";
      };
    };
  };
}
