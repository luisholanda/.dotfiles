# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.consoleMode = "auto";
  boot.loader.efi.canTouchEfiVariables = true;

  boot.cleanTmpDir = true;
  boot.consoleLogLevel = 4;
  boot.extraModulePackages = [ pkgs.firmware-rtl8188eu ];
  boot.initrd.availableKernelModules =
    [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelPackages = pkgs.linuxPackages_5_10;
  boot.kernelModules = [ "kvm-intel" "8188eu" ];
  boot.kernelParams = [
    # Slab/slub sanity checks, redzoning, and poisoning
    "slub_debug=FZP"
    # Enable page allocator randomization
    "page_alloc.shuffle=1"
    # Reduce TTY output during boot
    "quiet"
    "vga=current"
  ];
  boot.blacklistedKernelModules = [
    # Bad Realtek driver
    "r8188eu"

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
  boot.kernel.sysctl = { "fs.inotify.max_user_watches" = 524288; };

  fileSystems = {
    "/" = {
      label = "nixos";
      fsType = "xfs";
    };
    "/boot" = {
      label = "boot";
      fsType = "vfat";
    };
  };

  swapDevices = [{
    label = "swap";
    priority = 1;
  }];

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
    opengl = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
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
