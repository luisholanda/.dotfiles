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

  environment.systemPackages = with pkgs; [
    cmake
    curl
    coreutils
    wget
    dnscrypt-proxy2
  ] ++ optionals isDarwin [
    alacritty
    pinentry_mac
  ]
  ++ optional isLinux pinentry;

  environment.shells = optional fishEnable pkgs.fish;
  users.users."${user.name}" = user;

  system.stateVersion = 4;
}
