self: super:
let
  inherit (self) lib stdenv fetchFromGitHub fetchpatch;
  version = "2021-05-31";
in {
  rust-analyzer-unwrapped = self.rustPlatform.buildRustPackage {
    inherit version;

    pname = "rust-analyzer-unwrapped";
    cargoSha256 = "0y5wpqgzjqknslwjf0hapxbnfza05jllr1akv88c9c6yzmqfkmva";

    src = fetchFromGitHub {
      owner = "rust-analyzer";
      repo = "rust-analyzer";
      rev = version;
      sha256 = "1qihbdhql4n263q0piqmm4j0n33a336m6akm8ckb4dpgm7vd4v5z";
    };

    buildAndTestSubdir = "crates/rust-analyzer";

    cargoBuildFlags = "--features=mimalloc";

    nativeBuildInputs = [self.cmake];

    patches = [
      # Revert updates which require rust 1.52.0.
      # We currently have rust 1.51.0 in nixpkgs.
      # https://github.com/rust-analyzer/rust-analyzer/pull/8718
      (fetchpatch {
        url = "https://github.com/rust-analyzer/rust-analyzer/pull/8718/commits/607d8a2f61e56fabb7a3bc5132592917fcdca970.patch";
        sha256 = "sha256-g1yyq/XSwGxftnqSW1bR5UeMW4gW28f4JciGvwQ/n08=";
        revert = true;
      })
      (fetchpatch {
        url = "https://github.com/rust-analyzer/rust-analyzer/pull/8718/commits/6a16ec52aa0d91945577c99cdf421b303b59301e.patch";
        sha256 = "sha256-n7Ew/0fG8zPaMFCi8FVLjQZwJSaczI/QoehC6pDLrAk=";
        revert = true;
      })
    ];

    buildInputs = lib.optionals stdenv.isDarwin [
      self.CoreServices
      self.libiconv
    ];

    RUST_ANALYZER_REV = version;

    doCheck = false;
    doInstallCheck = true;
    installCheckPhase = ''
      runHook preInstallCheck
      versionOutput="$($out/bin/rust-analyzer --version)"
      echo "'rust-analyzer --version' returns: $versionOutput"
      [[ "$versionOutput" == "rust-analyzer ${version}" ]]
      runHook postInstallCheck
    '';

    passthru.updateScript = ./update.sh;

    meta = with lib; {
      description = "An experimental modular compiler frontend for the Rust language";
      homepage = "https://github.com/rust-analyzer/rust-analyzer";
      license = with licenses; [ mit asl20 ];
      maintainers = with maintainers; [ oxalica ];
    };
  };
  rust-analyzer = super.rust-analyzer.override {
    inherit version;
  };
}
