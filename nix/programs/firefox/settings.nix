{ config, ... }:
{
  app = {
    normandy = {
      enabled = false;
      api_url = "";
    };
    update.auto = false;
  };
  beacon.enabled = false;
  breakpad.reportURL = "";
  browser = {
    bookmarks.showMobileBookmarks = false;
    ctrlTab.recentlyUsedOrder = false;
    crashReports.unsubmittedCheck = {
      enabled = false;
      autoSubmit2 = false;
    };
    discovery.enabled = false;
    link = {
      open_newwindow = 3;
      "open_newwindow.restriction" = 0;
    };
    newtabpage.enabled = false;
    send_pings = false;
    "send_pings.require_same_host" = true;
    sessionstore.interval = 60 * 1000;
    startup.page = 0;
    tabs.crashReporting.sendReport = false;
    uidensity = 1;
    urlbar.placeholderName = "DuckDuckGo";
    xul.error_pages.expert_bad_cert = true;
  };
  datareporting = {
    healthreport.uploadEnabled = false;
    policy.dataSubmissionEnabled = false;
  };
  dom = {
    disable_open_during_load = true;
    disable_window_move_resize = true;
    popup_allowed_events = "click dblclick";
    ipc.plugins = {
      flash.subprocess.crashreporter.enabled = false;
      reportCrashURL = false;
    };
    security.https_only_mode = true;
    targetBlankNoOpener.enabled = true;
  };
  extensions = {
    pocket.enabled = false;
    getAddons.showPane = false;
    htmlaboutaddons.recommendations.enabled = false;
    blocklist.enabled = true;
  };
  gfx = {
    font_rendering = {
      coretext.enabled = true;
      graphite.enabled = false;
      opentype_svg.enabled = false;
    };

    webrender = {
      all = true;
      enabled = true;
    };
  };
  identity.fxaccounts.account.device.name = config.networking.hostName;
  javascript = {
    use_us_english_locale = false;
  };
  media.peerconnection = {
    enabled = true;
    ice = {
      default_address_only = true;
      no_host = true;
      proxy_only_if_behind_proxy = true;
    };
  };
  network = {
    cookie = {
      cookieBehavior = 1;
      thirdparty = {
        sessionOnly = true;
        nonsecureSessionOnly = true;
      };
    };
    dns.disableIPv6 = true;
    http = {
      redirection-limit = 10;
      referer = {
        defaultPolicy = 2;
        XOriginPolicy = 1;
        XOriginTrimmingPolicy = 0;
      };
    };
    trr.mode = 5; # The system DNS already does DoH to cloudflare.
  };
  plugin.state.flash = 0;
  privacy = {
    donottrackheader.enabled = true;
    resistFingerprinting = true;
    trackingprotection = {
      enabled = true;
      socialtracking = {
        enabled = true;
        annotate.enabled = true;
      };
    };
  };
  security = {
    cert_pinning.enforcement_level = 2;
    insecure_connection_text.enabled = true;
    mixed_content = {
      block_active_content = true;
      block_display_content = true;
      block_object-subrequest = true;
    };
    OCSP = {
      enabled = true;
      require = true;
    };
    pki.sha1_enforcement_level = 1;
    ssl = {
      enable_csp_stapling = true;
      require_safe_negotiation = false;
      disable_session_identifiers = true;
      errorReporting = {
        automatic = false;
        enabled = false;
        url = "";
      };
    };
    tls = {
      version.enable-deprecated = false;
      enable_0rtt_data = false;
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
      unified = false;
      enabled = false;
      server = "data:,";
      archive.enabled = false;
      newProfilePing.enabled = false;
      updatePing.enabled = false;
      bhrPing.enabled = false;
      firstShutdownPing.enabled = false;
      coverage.opt-out = true;
      pioneer-new-studies-available = false;
    };
    coverage.opt-out = true;
    coverage.endpoint.base = "";
    legacyUserProfileCustomizations.stylesheets = true;
  };
  urlclassifier.trackingTable = "moztest-track-simple,ads-track-digest256,social-track-digest256,analytics-track-digest256";
}
