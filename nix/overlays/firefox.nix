self: super:
{
  firefox = self.installApplication rec {
    name = "Firefox";
    version = "84.0.1";

    description = "The Firefox web browser";
    homepage = "https://www.mozilla.org/en-US/firefox/";

    src = super.fetchurl {
      name = "Firefox-${version}.dmg";
      url = "https://ftp.mozilla.org/pub/firefox/releases/${version}/mac/en-US/Firefox%20${version}.dmg";
      sha256 = "159jkkyzhsq66c0fvq10yvaq03wahg8xxhhvrqj58r74qg4c93wy";
    };
  };
}
