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
  telegram = self.installApplication rec {
    name = "Telegram";
    version = "2.5.5";

    description = "Telegram Desktop messaging app";
    homepage = "https://desktop.telegram.org";

    src = super.fetchurl {
      name = "${name}-${version}.dmg";
      url =  "https://github.com/telegramdesktop/tdesktop/releases/download/v${version}/tsetup.${version}.beta.dmg";
      sha256 = "1bj7abnh8h0fkkbdbn26d9fghlwywrxlvkmhwri2lw9bcp3r69dn";
    };
  };
})]
