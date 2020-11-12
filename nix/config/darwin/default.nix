super@{ config, lib, pkgs, ... }:

let
  user = config.users.users.luiscm;
  wm = import ./wm.nix super;
in wm // {
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  system = import ./system.nix super;
}
