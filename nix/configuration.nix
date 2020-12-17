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
  nix.nixPath = (import ./channels).nixPath;

  environment.systemPackages = with pkgs; [
    cmake
    curl
    coreutils
    wget
    dnscrypt-proxy2
  ];

  environment.shells = optional fishEnable pkgs.fish;
  users.users."${user.name}" = user;

  networking = {
    computerName = "MacBook Pro de Luis";
    hostName = "MacBook-Pro-de-Luis";
    knownNetworkServices =
      [ "USB 10/100/1000 LAN" "Wi-Fi" "Bluetooth PAN" "Thunderbolt Bridge" ];
  };

  system.stateVersion = 4;
}
