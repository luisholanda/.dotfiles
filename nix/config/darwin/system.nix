{ config, ... }:
{
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
      _HIHideMenuBar = config.services.spacebar.enable;

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
}
