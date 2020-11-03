super@{ config, lib, pkgs, ... }:

with pkgs.stdenv;
with lib;
let
  myUserCfg = config.home-manager.users.luiscm;
  fishEnable = myUserCfg.programs.fish.enable;
  user = rec {
    name = "luiscm";
    home = if isDarwin
      then "/Users/${name}"
      else "/home/${name}";
    shell = optional fishEnable pkgs.fish;
  };
in rec {
  imports = [
    <home-manager/nix-darwin>
    ./config
    ./modules/services/dnscrypt-proxy2
    ./services
  ];

  environment.systemPackages = with pkgs; [
    cmake
    curl
    coreutils
    wget
    dnscrypt-proxy2
  ] ++ optional isDarwin pkgs.pinentry_mac
    ++ optional isLinux pkgs.pinentry;

  environment.shells = optional fishEnable pkgs.fish;
  users.users."${user.name}" = user;

  networking = {
    computerName = "MacBook Pro de Luis";
    hostName = "MacBook-Pro-de-Luis";
    knownNetworkServices =
      [ "USB 10/100/1000 LAN" "Wi-Fi" "Bluetooth PAN" "Thunderbolt Bridge" ];
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.skhd = {
    enable = true;
    skhdConfig = builtins.readFile "${users.users.luiscm.home}/.dotfiles/skhdrc";
  };

  services.yabai = {
    enable = true;
    package = pkgs.yabai;
    enableScriptingAddition = true;
    config = rec {
      mouse_follows_focus = "on";
      focus_follows_mouse = "autoraise";
      window_placement = "second_child";
      window_topmost = "on";
      window_opacity = "on";
      window_shadow = "float";
      window_border = "off";
      active_window_opacity = 1.0;
      normal_window_opacity = 0.98;
      split_ratio = 0.5;
      auto_balance = "on";
      mouse_modifier = "fn";
      mouse_action1 = "move";
      mouse_action2 = "resize";
      layout ="bsp";
      window_gap = 4;
      top_padding = 4;
      bottom_padding = top_padding;
      left_padding = top_padding;
      right_padding = top_padding;
    };
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
        InitialKeyRepeat = 15;
        KeyRepeat = 1;
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
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
  };
}
