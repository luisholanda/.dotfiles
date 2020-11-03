super@{ lib, pkgs, ... }:

with pkgs.stdenv;
with lib;
{
  imports = [ ./darwin ./nix.nix ./home.nix ];
}
