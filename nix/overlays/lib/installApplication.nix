self: super: {
  installApplication = { name, appname ? name, version, src, description, homepage
    , postInstall ? "", sourceRoot ? ".", ... }:
    with super;
    stdenv.mkDerivation {
      inherit src sourceRoot;

      name = "${name}-${version}";
      version = "${version}";

      buildInputs = [ undmg unzip ];
      phases = [ "unpackPhase" "installPhase" ];
      installPhase = ''
        mkdir -p "$out/Applications/${appname}.app"
        mv ${appname}.app "$out/Applications/"
      '' + postInstall;
      meta = with self.lib; {
        inherit description homepage;
        platforms = platforms.darwin;
      };
    };
}
