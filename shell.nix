{ pkgs ? import <nixpkgs> {} }:
let
  inherit (pkgs) mkShell;
in mkShell {
  name = "dotfiles";
  packages = with pkgs; [ nixfmt luaformatter ];
}
