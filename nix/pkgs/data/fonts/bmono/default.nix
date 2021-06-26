{ lib, fetchzip, ... }:
let version = "1.1-5.0.1-0";
in fetchzip {
  name = "bmono-${version}";
  url = "https://github.com/NNBnh/bmono/releases/download/${version}/bmono-ttf.zip";
  sha256 = "16iz3c1yjvx72c25nmrbpjhvmmi5270bqil38fa9h7a1wxh758yn";

  postFetch = ''
    unzip $downloadedFile
    mkdir -p $out/share/fonts/truetype
    cp -r ttf $out/share/fonts/truetype/bmono
  '';

  meta = with lib; {
    description = "Mono font that SuperB";
    homepage = "https://github.com/NNBnh/bmono";
    license = licenses.ofl;
    platforms = platforms.all;
  };
}
