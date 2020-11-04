super@{ config, lib, pkgs, ... }:

let
  user = config.users.users.luiscm;
  wm = import ./wm.nix super;
in {
  inherit (wm) services;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  system = import ./system.nix;
}
