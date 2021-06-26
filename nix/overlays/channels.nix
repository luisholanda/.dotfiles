self: super:
let
  channels = import ../channels { pkgs = self; };
  rustOverlayRev = "4f2051c76032e86338219f477e5ac9e522dd362a";
in {
  nur = import channels.nur { pkgs = self; };
  unstable = import channels.nixpkgs-unstable { };
  rust-bin = import (builtins.fetchTarball
    "https://github.com/oxalica/rust-overlay/archive/${rustOverlayRev}.tar.gz") { };
}
