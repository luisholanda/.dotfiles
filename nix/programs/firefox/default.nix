{ config, pkgs, ... }:

with pkgs.myLib;
let
  defaultSettings = {
    app.update.auto = false;
    browser = {
      bookmarks.showModileBookmarks = false;
      ctrlTab.recentlyUsedOrder = false;
      search = {
        region = "US";
        countrCode = "US";
      };
      send_pings = false;
      sessionstore.interval = 60 * 1000;
      uidensity = 1;
      urlbar.placeholderName = "DuckDuckGo";
    };
    extensions.pocket.enabled = false;
    gfx.webrender = {
      all = true;
      enabled = true;
    };
    identity.fxaccounts.account.device.name = config.networking.hostName;
    media.peerconnection.enabled = false;
    network = {
      http = {
        sendRefererHeader = 1;
        referer = {
          defaultPolyicy = 2;
          trimmingPolicy = 1;
          XOriginTrimmingPolicy = 2;
        };
      };
      trr.mode = 5; # The system DNS already does DoH to cloudflare.
    };
    privacy = {
      donottrackheader.enabled = true;
      firstparty.isolate = true;
      resistFingerprinting = true;
      trackingprotection = {
        enabled = true;
        socialtracking = {
          enabled = true;
          annotate.enabled = true;
        };
      };
    };
    services.sync = {
      engine = {
        addons = false;
        passwords = false;
        prefs = false;
      };
      engineStatusChanged = {
        addons = true;
        prefs = true;
      };
    };
    signon.rememberSignons = false;
    toolkit = {
      telemetry = {
        enabled = false;
        pioneer-new-studies-available = true;
      };
      legacyUserProfileCustomizations.stylesheets = true;
    };
    urlclassifier.trackingTable = "moztest-track-simple,ads-track-digest256,social-track-digest256,analytics-track-digest256,content-track-digest256";
  };
in {
  enable = true;
  package = pkgs.firefox;

  extensions =
    with pkgs.nur.repos.rycee.firefox-addons; [
      bitwarden
      https-everywhere
      multi-account-containers
      refined-github
      vim-vixen
    ];

  profiles = {
    home = {
      id = 0;

      settings = flattenAttrs defaultSettings;
      userChrome = builtins.readFile ./userChrome.css;
    };
  };
}
