# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware.nix
      ./security.nix
      <home-manager/nixos>
      ../../config/home.nix
      ../../config/nix.nix
    ];

  console.colors = (import ../../config/colors.nix).term;

  documentation = {
    dev.enable = true;
    doc.enable = true;
    man.generateCaches = true;
  };

  # TODO: Study better if we want this or not
  # environment.memoryAllocator.provider = "jemalloc";
  # TODO: We use Wayland instead of Xorg
  # environment.noXlibs = true;

  environment.shells = [ pkgs.fish ];
  environment.shellInit = ''
    if [[ "$tty" = "/dev/tty1" ]]; then
      exec ${pkgs.sway}/bin/sway
    fi
  '';
  environment.systemPackages = with pkgs; [
    brightnessctl
    curl
    coreutils
    dhcpcd
    gtk-engine-murrine
    gtk_engines
    gsettings-desktop-schemas
    lxappearance
    wget
  ];

  fonts = {
    # TODO: Maybe we should drop this and list the specific fonts we want?
    enableDefaultFonts = true;
    enableFontDir = true;
    fontconfig = {
      useEmbeddedBitmaps = true;
    };

    fonts = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
  };

  location.provider = "geoclue2";

  networking = {
    enableIPv6 = false;
    hostId = "cb4a1fd3";
    hostName = "plutus";

    # TODO: replace network manager with wpa_suppliant
    networkmanager.enable = true;

    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
    interfaces.eno1.useDHCP = true;
  };

  nix.trustedUsers = [ "root" "luiscm" ];
  nix.allowedUsers = [ "@wheel" "@builders" ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.pulseaudio = true;
  nixpkgs.overlays = import ../../overlays;

  programs.adb.enable = true;
  programs.qt5ct.enable = true;
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      kanshi
      swaylock
      swayidle
      xwayland
      waybar
      wl-clipboard
      wofi
    ];
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export _JAVA_AWT_WM_NOREPARENTING=1
      export MOZ_ENABLE_WAYLAND=1
      export XDG_CURRENT_DESKTOP=sway
    '';
  };
  programs.waybar.enable = true;

  services.blueman.enable = true;
  services.localtime.enable = true;
  services.locate = {
    enable = true;
    interval = "12:20";
  };
  services.redshift = {
    enable = true;
    package = pkgs.redshift-wlr;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

  systemd.user.targets.sway-session = {
    description = "Sway compositor session";
    documentation = [ "man:systemd.special(7)" ];
    bindsTo = [ "graphical-session.target" ];
    wants = [ "graphical-session-pre.target" ];
    after = [ "graphical-session-pre.target" ];
  };

  systemd.user.services.kanshi = {
    description = "Kanshi output autoconfig";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.kanshi}/bin/kanshi";
      RestartSec = 5;
      Restart = "always";
    };
  };

  systemd.user.services.mpris-proxy = {
    description = "MPRIS proxy";
    after = [ "network.target" "sound.target" ];
    wantedBy = [ "default.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
      RestartSec = 5;
      Restart = "always";
    };
  };

  users.mutableUsers = false;
  users.users.luiscm = {
    createHome = true;
    description = "Luis C. M. de Holanda";
    extraGroups = [ "wheel" "networking" "video" "adbusers" ];
    home = "/home/luiscm";
    isNormalUser = true;
    hashedPassword = "$6$9FTY2/BA$SNnE6OAWlL4fK/cURdYQUJ33pp6xMQcUsFCkzD1HnDidI.cP6WDmQMUhYapi/NiAT3gXKh//N09q2fYO1V3eN.";
    shell = pkgs.fish;
  };

  virtualisation.docker = {
    enable = true;
    autoPrune = { enable = true; };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-wlr ];
    gtkUsePortal = true;
  };
}

