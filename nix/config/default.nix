super@{ lib, pkgs, ... }:

with pkgs.stdenv;
with lib;
{
  imports = [ ./nix.nix ./home.nix ];
}
