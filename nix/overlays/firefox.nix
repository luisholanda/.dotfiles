self: super:
{
  firefox = self.installApplication rec {
    name = "Firefox";
    version = "83.0";

    description = "The Firefox web browser";
    homepage = "https://www.mozilla.org/en-US/firefox/";

    src = super.fetchurl {
      name = "Firefox-${version}.dmg";
      url = "https://ftp.mozilla.org/pub/firefox/releases/${version}/mac/en-US/Firefox%20${version}.dmg";
      sha256 = "1ikfcdsz0pgaiwal47fnbybam513p5a1fn99g74wcf80wj27hlky";
    };
  };
}
