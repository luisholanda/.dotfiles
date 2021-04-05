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
in fileOverlays ++ [(self: super: {
  devicon-lookup = self.rustPlatform.buildRustPackage rec {
    pname = "devicon-lookup";
    version = "0.8.0";

    src = super.fetchFromGitHub {
      owner = "coreyja";
      repo = pname;
      rev = version;
      sha256 = "0v4jc9ckbk6rvhw7apdfr6wp2v8gfx0w13gwpr8ka1sph9n4p3a7";
    };

    cargoSha256 = "048yb45zr589gxvff520wh7cwlhsb3h64zqsjfy85c5y28sv6sas";
  };

  obs-studio = super.obs-studio.overrideAttrs (old: {
    src = self.fetchFromGitHub {
      owner = "GeorgesStavracas";
      repo = "obs-studio";
      rev = "6641603eeff695113e7fc738a855efece6750ac1";
      sha256 = "0bx2hh1ysc2fk88zlviy934gxs8vbfxc4cc614b2qz44bd1xh4jr";
    };

    buildInputs = [ self.pipewire ] ++ old.buildInputs;
    cmakeFlags = ["-DENABLE_PIPEWIRE=ON"] ++ old.cmakeFlags;
  });

  #steam = super.steam.override {
  #  extraLibraries = pkgs: with pkgs; [
  #    libxkbcommon
  #    mesa
  #    wayland
  #    sndio
  #  ];
  #};

  vaapiIntel = super.vaapiIntel.override { enableHybridCodec = true; };

  waybar = super.waybar.override {
    pulseSupport = true;
    libdbusmenu-gtk3 = self.libappindicator;
  };

  yabai = super.yabai.overrideAttrs (o: rec {
    version = "v3.3.7";
    src = builtins.fetchTarball {
      url = "https://github.com/koekeishiya/yabai/releases/download/${version}/yabai-${version}.tar.gz";
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
})]
