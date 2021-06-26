super@{ lib, config, pkgs, ... }:
let
  mkIfLinux = x: lib.mkIf pkgs.stdenv.isLinux x;
  enableIfLinux = mkIfLinux { enable = true; };
in {
  imports = [ ./dnscrypt-proxy2.nix ];

  services = mkIfLinux {
    irqbalance.enable = true;

    pipewire = {
      enable = !(config.hardware.pulseaudio.enable || config.sound.enable);
      pulse.enable = true;
      jack.enable = false;
      alsa.enable = true;
    };

    #pulseeffects.enable = true;
  };

  home-manager.users.luiscm.services = mkIfLinux {
    kanshi.enable = true;
    pulseeffects = {
      enable = true;
      package = pkgs.pulseeffects-pw;
    };
  };
}
