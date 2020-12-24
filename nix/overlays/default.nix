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
})]
