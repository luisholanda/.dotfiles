let
  overlays = [
    ./installApplication.nix
    ./firefox.nix
    ./myLib.nix
    ./neovim.nix
  ];
in builtins.map (x: import x) overlays
