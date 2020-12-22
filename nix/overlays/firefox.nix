self: super:
{
  firefox = self.installApplication rec {
    name = "Firefox";
    version = "84.0";

    description = "The Firefox web browser";
    homepage = "https://www.mozilla.org/en-US/firefox/";

    src = super.fetchurl {
      name = "Firefox-${version}.dmg";
      url = "https://ftp.mozilla.org/pub/firefox/releases/${version}/mac/en-US/Firefox%20${version}.dmg";
      sha256 = "1zgyhyppz45sy79d20blqq1kwiw71aprb61sz7vg8a5j1q2wlysc";
    };
  };
}
