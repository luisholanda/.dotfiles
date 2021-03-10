super@{ config, lib, pkgs, ... }:

with pkgs.stdenv;
with lib;
let
  myUserCfg = config.home-manager.users.luiscm;
  fishEnable = myUserCfg.programs.fish.enable;
  user = rec {
    name = "luiscm";
    home = if isDarwin
      then "/Users/${name}"
      else "/home/${name}";
    shell = optional fishEnable pkgs.fish;
  };

in
{
  imports = [
    <home-manager/nix-darwin>
    ./config
    ./modules/services/dnscrypt-proxy2
    ./services
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = import ./overlays;
  nix.nixPath = (import ./channels).nixPathStr;

  environment.systemPackages = with pkgs; [
    cmake
    curl
    coreutils
    wget
  ];

  environment.shells = optional fishEnable pkgs.fish;
  users.users."${user.name}" = user;

  networking = {
    computerName = "MacBook Pro de Luis";
    hostName = "MacBook-Pro-de-Luis";
    knownNetworkServices =
      [ "USB 10/100/1000 LAN" "Wi-Fi" "Bluetooth PAN" "Thunderbolt Bridge" ];
  } // optionalAttrs (!config.services.dnscrypt-proxy2.enable) {
    dns = ["1.1.1.2" "1.0.0.2"];
  };

  system.stateVersion = 4;
}
