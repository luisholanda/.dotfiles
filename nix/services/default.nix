super@{ lib, pkgs, ... }:
let
  mkIfLinux = x: lib.mkIf pkgs.stdenv.isLinux x;
  enableIfLinux = mkIfLinux { enable = true; };
in {
  imports = [
    ./dnscrypt-proxy2.nix
  ];

  gpg-agent = mkIfLinux {
    enable = true;
    defaultCacheTtl = 600;
    maxCacheTtl = 7200;
    enableSshSupport = true;
  };

  irqbalance = enableIfLinux;

  # Support WebRTC and simillars
  pipewire = enableIfLinux;

  pulseeffects = enableIfLinux;
}
