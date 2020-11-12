self: super:
{
  nur = import (super.fetchFromGitHub {
    owner = "nix-community";
    repo = "nur-combined";
    rev = "d49380f73b0389d3321d420086cd605ee6a0846f";
    sha256 = "0qw4757m3i9n61cd8544kd8ynl8m1zvjsh44mpgg3nm82i455csx";
  }) { pkgs = self; };
  unstable = import <nixpkgs-unstable> { pkgs = self; };
}
