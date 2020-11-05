self: super:
{
  rust-analyzer = with super; stdenv.mkDerivation rec {
    name = "rust-analyzer";
    version = "2020-11-02";

    src = with stdenv; fetchurl rec {
      name = "rust-analyzer-${if isDarwin then "mac" else "linux"}.gz";
      url = "https://github.com/rust-analyzer/rust-analyzer/releases/download/${version}/${name}";
      sha256 = if isDarwin
        then "10c3r1ayri7rv57dw05ig30r9fa1a09bjfqaspx0gg7p538jms36"
        else "1dn8pb15cfbn7bwni9843750bmw97724zsynkzg6fmlji1dbzlww";
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
