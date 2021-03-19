self: super:
{
  firefox = self.installApplication rec {
    name = "Firefox";
    version = "84.0.2";

    description = "The Firefox web browser";
    homepage = "https://www.mozilla.org/en-US/firefox/";

    src = super.fetchurl {
      name = "${name}-${version}.dmg";
      url = "https://ftp.mozilla.org/pub/firefox/releases/${version}/mac/en-US/Firefox%20${version}.dmg";
      sha256 = "1xycm3v8ix1lg91qv3kwihqbvq877crx88jn9vqaczvzl1zrdbic";
    };
  };
}
