self: super:
let
  channels = import ../channels { pkgs = self; };
in {
  nur = import channels.nur { pkgs = self; };
  unstable = import channels.nixpkgs-unstable {};
}
