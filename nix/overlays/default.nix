let
  overlays = [
    ./channels.nix
    ./installApplication.nix
    ./emacs.nix
    ./firefox.nix
    ./myLib.nix
    ./neovim.nix
    ./rust-analyzer.nix
  ];
  fileOverlays = builtins.map (x: import x) overlays;
in fileOverlays ++ [(self: super: {
  ccls = super.ccls.override {
    llvmPackages = self.unstable.llvmPackages_11;
  };
  telegram = let
    name = "Telegram";
    version = "2.5.8";
    isBeta = false;
  in self.installApplication {
    inherit version name;

    description = "Telegram Desktop messaging app";
    homepage = "https://desktop.telegram.org";

    src = super.fetchurl {
      name = "${name}-${version}.dmg";
      url =  let
        urlVersion = if isBeta
          then "${version}.beta"
          else "${version}";
      in "https://github.com/telegramdesktop/tdesktop/releases/download/v${version}/tsetup.${urlVersion}.dmg";
      sha256 = "1yprjglkbpgbkjv2j1nmw32gx0ph3c6f0n3c5ykwyf7c37v9aaxn";
    };
  };
  waybar = super.waybar.override {
    pulseSupport = true;
    libdbusmenu-gtk3 = self.libappindicator;
  };
  yabai = super.yabai.overrideAttrs (o: rec {
    version = "3.3.7";
    src = builtins.fetchTarball {
      url = "https://github.com/koekeishiya/yabai/releases/download/v${version}/yabai-v${version}.tar.gz";
      sha256 = "1ywccgqajyqb8pqaxap2dci6wy2jba6snrzsiawdmnbvv1bsp3z2";
    };

    installPhase = ''
      mkdir -p $out/bin
      mkdir -p $out/share/man/man1/
      cp ./archive/bin/yabai $out/bin/yabai
      cp ./archive/doc/yabai.1 $out/share/man/man1/yabai.1
    '';
  });
})]
