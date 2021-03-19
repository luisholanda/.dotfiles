self: super:
let
  inherit (self.stdenv) mkDerivation isDarwin;
in {
  rust-analyzer = mkDerivation rec {
    name = "rust-analyzer";
    version = "2021-03-01";

    src = builtins.fetchurl rec {
      name = "rust-analyzer-${if isDarwin then "mac" else "linux"}.gz";
      url = "https://github.com/rust-analyzer/rust-analyzer/releases/download/${version}/${name}";
      sha256 = if isDarwin
        then "1yqlsg1jwqkssg42rbsrp9g86l3iwziyyfhxix76akq4xjyklh3n"
        else "1d7k2sgpgfmcly5maa0lxmkrc3gdh2nyjbk6fxh4kjq7zxghmqgc";
    };

    buildInputs = [ self.gzip ];
    phases = [ "unpackPhase" "installPhase" ];
    sourceRoot = ".";
    unpackCmd = "gunzip -c $src > ./rust-analyzer";
    installPhase = ''
      mkdir -p $out/bin
      chmod +x rust-analyzer
      mv rust-analyzer $out/bin/rust-analyzer
    '';

    meta = with self.lib; {
      description = "An experimental modular compiler frontend for the Rust language";
      homepage = "https://github.com/rust-analyzer/rust-analyzer";
      license = with licenses; [ mit asl20 ];
      platforms = platforms.x86_64;
    };
  };
}
