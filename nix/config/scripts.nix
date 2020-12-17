{ lib, pkgs, ... }:
with lib;
with pkgs.stdenv;
let
  scriptFromFile = name: path: pkgs.writeScriptBin name (readFile path);
  baseScripts = [];
  darwinScripts = [
    (scriptFromFile "login-cloud-sql" ../../scripts/osx/gcp/login-cloud-sql)
  ];
  linuxScripts = [];
in
  baseScripts
  ++ optionals isDarwin darwinScripts
  ++ optionals isLinux linuxScripts
