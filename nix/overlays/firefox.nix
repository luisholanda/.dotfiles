self: super:
{
  firefox = self.installApplication rec {
    name = "Firefox";
    version = "82.0.2";

    description = "The Firefox web browser";
    homepage = "https://www.mozilla.org/en-US/firefox/";

    src = super.fetchurl {
      name = "Firefox-${version}.dmg";
      url = "https://ftp.mozilla.org/pub/firefox/releases/${version}/mac/en-US/Firefox%20${version}.dmg";
      sha256 = "1q0bp9a4cv3x8hcsknq2a7gm67jg61rppmxd913sdcr8709qydh9";
    };
  };
}
