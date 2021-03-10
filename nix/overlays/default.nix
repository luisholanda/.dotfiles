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
  fish-foreign-env = super.fishPlugins.foreign-env;
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
