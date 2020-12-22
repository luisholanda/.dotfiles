super@{ config, lib, pkgs, ... }:

let
  user = config.users.users.luiscm;
  wm = import ./wm.nix super;
in wm // {
  environment.darwinConfig = "${user.home}/.dotfiles/nix/configuration.nix";
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  system = import ./system.nix super;
}
