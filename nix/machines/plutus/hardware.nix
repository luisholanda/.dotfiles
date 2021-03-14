# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.consoleMode = "auto";
  boot.loader.efi.canTouchEfiVariables = true;

  boot.cleanTmpDir = true;
  boot.consoleLogLevel = 4;
  boot.extraModulePackages = [ ];
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelModules = [ "kvm-intel" "btusb" ];
  boot.kernelPatches = [rec {
    name = "enable-btusb-module";
    patch = null;
    extraConfig = "BT_HCIBTUSB m";
  }];
  boot.kernelParams = [
    # Slab/slub sanity checks, redzoning, and poisoning
    "slub_debug=FZP"
    # Enable page allocator randomization
    "page_alloc.shuffle=1"
    # Fix weird CSR firmware behaviour
    "btusb.reset=1"
    "btusb.enable_autosuspend=0"
    # Reduce TTY output during boot
    "quiet"
    "vga=current"
  ];
  boot.blacklistedKernelModules = [
    # obscure network protocols
    "ax25"
    "netrom"
    "rose"

    # Old or rare or insufficiently audited filesystems
    "adfs"
    "affs"
    "bfs"
    "befs"
    "cramfs"
    "efs"
    "erofs"
    "exofs"
    "freevxfs"
    "f2f2"
    "hfs"
    "hpfs"
    "jfs"
    "minix"
    "nilfs2"
    "ntfs"
    "omfs"
    "qnx4"
    "qnx6"
    "sysv"
    "ufs"
  ];

  fileSystems = {
    "/" = { label = "nixos"; fsType = "xfs"; };
    "/boot" = { label = "boot"; fsType = "vfat"; };
  };

  swapDevices =
    [ { label = "swap"; priority = 1; }
    ];

  hardware = {
    brillo.enable = true;
    bluetooth = {
      enable = true;
      settings.General = {
        AutoConnect = "true";
        Enable = "Source,Sink,Media,Socket";
        FastConnectable = "true";
        MultiProfile = "multiple";
      };
    };
    cpu.intel.updateMicrocode = true;
    ksm.enable = true;
    pulseaudio = {
      enable = false;
      package = pkgs.pulseaudioFull;
      extraModules = [ pkgs.pulseaudio-modules-bt ];
      extraConfig = ''
        load-module module-switch-on-connect

        unload module-bluetooth-policy
        load-module module-bluetooth-policy auto_switch=2

        unload module-bluetooth-discover
        load-module module-bluetooth-discover headset=native
      '';
    };
    # high-resolution display
    video.hidpi.enable = lib.mkDefault true;
  };

  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";

  zramSwap.enable = true;
}
