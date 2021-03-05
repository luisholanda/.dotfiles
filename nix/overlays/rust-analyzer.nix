self: super:
{
  rust-analyzer = with super; stdenv.mkDerivation rec {
    name = "rust-analyzer";
    version = "2021-03-01";

    src = with stdenv; fetchurl rec {
      name = "rust-analyzer-${if isDarwin then "mac" else "linux"}.gz";
      url = "https://github.com/rust-analyzer/rust-analyzer/releases/download/${version}/${name}";
      sha256 = if isDarwin
        then "1yqlsg1jwqkssg42rbsrp9g86l3iwziyyfhxix76akq4xjyklh3n"
        else "0000000000000000000000000000000000000000000000000000";
    };

    buildInputs = [ gzip ];
    phases = [ "unpackPhase" "installPhase" ];
    sourceRoot = ".";
    unpackCmd = "gunzip -c $src > ./rust-analyzer";
    installPhase = ''
      mkdir -p $out/bin
      chmod +x rust-analyzer
      mv rust-analyzer $out/bin/rust-analyzer
    '';

    meta = with stdenv.lib; {
      description = "An experimental modular compiler frontend for the Rust language";
      homepage = "https://github.com/rust-analyzer/rust-analyzer";
      license = with licenses; [ mit asl20 ];
      platforms = platforms.darwin;
    };
  };
}
