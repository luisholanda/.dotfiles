{ lib, pkgs, ... }: {
  enable = true;
  package = pkgs.mpv-unwrapped.override {
    waylandSupport = true;
    x11Support = false;
    xineramaSupport = false;
    xvSupport = false;
    vapoursynthSupport = true;
    vapoursynth = pkgs.vapoursynth.withPlugins [ pkgs.vapoursynth-mvtools ];
  };

  config = {
    hwdec = "auto-safe";
    hwdec-codecs = "all";
    vo = "gpu";
    profile = "gpu-hq";
    gpu-context = "wayland";
    scale = "bicubic_fast";
  };
}
