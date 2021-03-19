self: super:
let
  channels = import ../channels { pkgs = self; };
in {
  nur = import channels.nur {};
  unstable = import channels.nixpkgs-unstable {};
}
