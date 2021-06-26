let
  overlays = [
    ./channels.nix
    ./applications/editors/emacs.nix
    ./applications/editors/neovim.nix
    ./applications/networking/browsers/firefox.nix
    ./applications/networking/instant-messengers/telegram.nix
    ./development/tools/rust/rust-analyzer.nix
    ./lib/installApplication.nix
    ./lib/myLib.nix
    ./os-specific/linux/firmware/rtl8188eu.nix
    ../pkgs
  ];
  fileOverlays = builtins.map (x: import x) overlays;
in fileOverlays ++ [
  (self: super: {
    vaapiIntel = super.vaapiIntel.override { enableHybridCodec = true; };

    waybar = super.waybar.override {
      pulseSupport = true;
      libdbusmenu-gtk3 = self.libappindicator;
    };

    yabai = super.yabai.overrideAttrs (o: rec {
      version = "v3.3.7";
      src = builtins.fetchTarball {
        url =
          "https://github.com/koekeishiya/yabai/releases/download/${version}/yabai-${version}.tar.gz";
        sha256 = "0bahqgx3lyb9ryw0gfxz0c6vyyf55fczcyhzc9frmmdqjaf04ccq";
      };

      installPhase = ''
        ls
        mkdir -p $out/bin
        mkdir -p $out/share/man/man1/
        cp ./bin/yabai $out/bin/yabai
        cp ./doc/yabai.1 $out/share/man/man1/yabai.1
      '';
    });
  })
]
