self: super:
{
  nur = import <nur> { pkgs = self; };
  unstable = import <nixpkgs-unstable> { pkgs = self; };
}
