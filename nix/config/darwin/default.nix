super@{ config, lib, pkgs, ... }:

let
  user = config.users.users.luiscm;
  wm = import ./wm.nix super;
in {
  inherit (wm) services;

  networking = {
    computerName = "MacBook Pro de Luis";
    hostName = "MacBook-Pro-de-Luis";
    knownNetworkServices =
      [ "USB 10/100/1000 LAN" "Wi-Fi" "Bluetooth PAN" "Thunderbolt Bridge" ];
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  system = import ./system.nix;
}
