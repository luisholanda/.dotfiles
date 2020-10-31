{ stdenv, pkgs, ... }:

rec {
  imports = [ <home-manager/nix-darwin> ./modules/services/dnscrypt-proxy2 ];
  environment.systemPackages = with pkgs; [
    cmake
    curl
    coreutils
    wget
    dnscrypt-proxy2
  ];

  environment.shells = [ pkgs.fish ];

  services.nix-daemon.enable = true;
  nix = rec {
    package = pkgs.nix;
    gc.automatic = true;
    useDaemon = true;
    buildCores = 4;
    useSandbox = true;
    binaryCaches = [ "https://cache.nixos.org/" ];
    trustedBinaryCaches = binaryCaches;
  };

  home-manager = {
    useUserPackages = false;
    useGlobalPkgs = false;

    users.luiscm = import (./home-configuration.nix) { inherit pkgs; };
  };

  users.users.luiscm = let user = home-manager.users.luiscm;
  in rec {
    name = user.home.username;
    home = user.home.homeDirectory;
    shell = if user.programs.fish.enable then pkgs.fish else pkgs.zsh;
  };

  networking = {
    computerName = "MacBook Pro de Luis";
    hostName = "MacBook-Pro-de-Luis";
    knownNetworkServices =
      [ "USB 10/100/1000 LAN" "Wi-Fi" "Bluetooth PAN" "Thunderbolt Bridge" ];
  };

  services.dnscrypt-proxy2 = {
    enable = true;

    settings = {
      server_names = [ "cloudflare-security" ];
      listen_addresses = [ "127.0.0.1:53" ];
      max_clients = 64;

      ipv4_servers = true;
      ipv6_servers = false;
      dnscrypt_servers = true;
      doh_servers = true;
      require_dnssec = true;
      require_nolog = true;
      require_nofilter = true;

      force_tcp = false;
      lb_strategy = "fastest";
      fallback_resolver = "8.8.8.8:53";
      ignore_system_dns = true;
      cache = true;
      cache_size = 8196;
      cache_min_ttl = 600;
      cache_max_ttl = 86400;
      cache_neg_min_ttl = 60;
      cache_neg_max_ttl = 600;

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

  services.skhd = let home = users.users.luiscm.home;
  in {
    enable = true;
    skhdConfig = builtins.readFile "${home}/.dotfiles/skhdrc";
  };


  system = {
    stateVersion = 4;

    defaults = {
      NSGlobalDomain = {
        AppleKeyboardUIMode = 3;
        AppleMetricUnits = 1;
        AppleMeasurementUnits = "Centimeters";
        ApplePressAndHoldEnabled = false;
        AppleShowAllExtensions = true;
        AppleShowScrollBars = "WhenScrolling";
        AppleTemperatureUnit = "Celsius";
        InitialKeyRepeat = 20;
        KeyRepeat = 5;
        NSTableViewDefaultSizeMode = 1;

        "com.apple.keyboard.fnState" = true;
        "com.apple.springing.delay" = "0.5";
        "com.apple.springing.enabled" = true;
        "com.apple.trackpad.scaling" = "0.875";
      };
      alf.stealthenabled = 1;
      dock = {
        autohide = true;
        launchanim = false;
        mineffect = "scale";
        mru-spaces = false;
        tilesize = 31;
      };
      finder.AppleShowAllExtensions = true;
      loginwindow = {
        PowerOffDisabledWhileLoggedIn = true;
        ShutDownDisabledWhileLoggedIn = true;
      };
      spaces.spans-displays = false;
      trackpad = {
        ActuationStrength = 0;
        Clicking = true;
        FirstClickThreshold = 0;
        SecondClickThreshold = 0;
      };
    };

    keyboard = {
      remapCapsLockToEscape = true;
    };
  };
}
