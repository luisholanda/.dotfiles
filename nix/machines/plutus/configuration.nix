# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ colors, config, lib, pkgs, ... }: {
  _module.args.colors = lib.mkDefault (import ../../config/colors.nix);

  imports = [ # Include the results of the hardware scan.
    ./hardware.nix
    ./security.nix
    ./desktop.nix
    <home-manager/nixos>
    ../../config/home.nix
    ../../config/nix.nix
    ../../services
  ];

  console.colors = colors.term;

  documentation = {
    dev.enable = false;
    doc.enable = true;
    man.generateCaches = true;
  };

  # TODO: Study better if we want this or not
  # environment.memoryAllocator.provider = "jemalloc";
  # TODO: We use Wayland instead of Xorg
  # environment.noXlibs = true;

  environment.sessionVariables = { XDG_CURRENT_DESKTOP = "sway"; };
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
    gtk-engine-murrine
    gtk_engines
    gsettings-desktop-schemas
    libappindicator
    lxappearance
    numix-gtk-theme
    numix-icon-theme
    numix-cursor-theme
    wget
    xdg_utils
    xdg-user-dirs
  ];

  fonts = {
    # TODO: Maybe we should drop this and list the specific fonts we want?
    enableDefaultFonts = true;
    fontDir.enable = true;
    fontconfig = {
      useEmbeddedBitmaps = true;
      defaultFonts = {
        monospace = [ "JetBrainsMono Nerd Font" ];
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
      };
    };

    fonts = with pkgs; [
      bmono
      font-awesome
      lmodern
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
  };

  location.provider = "geoclue2";

  networking = {
    hostId = "cb4a1fd3";
    hostName = "plutus";

    networkmanager = { enable = true; };
  };

  nix.trustedUsers = [ "root" "luiscm" ];
  nix.allowedUsers = [ "@wheel" "@builders" ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.pulseaudio = true;
  nixpkgs.overlays = import ../../overlays;

  programs.adb.enable = true;
  programs.qt5ct.enable = true;
  programs.ssh.startAgent = true;
  programs.steam.enable = false;
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [ swaylock swayidle xwayland waybar wl-clipboard wofi ];
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export _JAVA_AWT_WM_NOREPARENTING=1
      export MOZ_ENABLE_WAYLAND=1
      export XDG_CURRENT_DESKTOP=sway
    '';
  };

  services.blueman.enable = true;

  services.emacs = {
    enable = true;
    package = pkgs.emacsOverlay.emacsPgtkGcc;
  };

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
    extraGroups = [ "wheel" "networking" "video" "adbusers" "docker" ];
    home = "/home/luiscm";
    isNormalUser = true;
    hashedPassword =
      "$6$9FTY2/BA$SNnE6OAWlL4fK/cURdYQUJ33pp6xMQcUsFCkzD1HnDidI.cP6WDmQMUhYapi/NiAT3gXKh//N09q2fYO1V3eN.";
    shell = pkgs.fish;
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
    autoPrune = { enable = true; };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-wlr ];
    gtkUsePortal = true;
  };
}

