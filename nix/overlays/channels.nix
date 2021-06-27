self: super:
let
  channels = import ../channels { pkgs = self; };
  emacsUnstableRev = "d756e841ef2d30dcb9d831f47c2f2bc9b7eaaabf";
  rustOverlayRev = "4f2051c76032e86338219f477e5ac9e522dd362a";
in {
  emacsOverlay = import (builtins.fetchTarball
    "https://github.com/nix-community/emacs-overlay/archive/${emacsUnstableRev}.tar.gz") self super;
  nur = import channels.nur { pkgs = self; };
  unstable = import channels.nixpkgs-unstable { };
  rust-bin = import (builtins.fetchTarball
    "https://github.com/oxalica/rust-overlay/archive/${rustOverlayRev}.tar.gz") { };
}
