self: super:
let channels = import ../channels;
in {
  nur = import channels.nur { pkgs = self; };
  unstable = import channels.nixpkgs-unstable { pkgs = self; };
}
