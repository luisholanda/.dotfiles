self: super:
{
  firefox = self.installApplication rec {
    name = "Firefox";
    version = "82.0.3";

    description = "The Firefox web browser";
    homepage = "https://www.mozilla.org/en-US/firefox/";

    src = super.fetchurl {
      name = "Firefox-${version}.dmg";
      url = "https://ftp.mozilla.org/pub/firefox/releases/${version}/mac/en-US/Firefox%20${version}.dmg";
      sha256 = "10srb6pjy729zl71gsammp294kg531m3fgghd8lrw05pbm9lxxy1";
    };
  };
}
