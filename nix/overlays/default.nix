let
  overlays = [
    ./channels.nix
    ./installApplication.nix
    ./firefox.nix
    ./myLib.nix
    ./neovim.nix
    ./rust-analyzer.nix
  ];
in builtins.map (x: import x) overlays
