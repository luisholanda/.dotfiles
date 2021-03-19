self: super:
let
  inherit (self.stdenv) isDarwin;

  version = "2.7.0";
  isBeta = false;
in {
  tdesktop = if isDarwin
    then self.installApplicaton rec {
      inherit version;
      name = "Telegram";

      description = "Telegram Desktop messaging app";
      homepage = "https://desktop.telegram.org";

      src = super.fetchurl {
        name = "${name}-${version}.dmg";
        url =  let
          urlVersion = if isBeta
            then "${version}.beta"
            else "${version}";
        in "https://github.com/telegramdesktop/tdesktop/releases/download/v${version}/tsetup.${urlVersion}.dmg";
        sha256 = "1yprjglkbpgbkjv2j1nmw32gx0ph3c6f0n3c5ykwyf7c37v9aaxn";
      };
    }
    else super.tdesktop.overrideAttrs {
      inherit version;
    };
}
