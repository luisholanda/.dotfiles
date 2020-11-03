let
  overlays = [
    ./installApplication.nix
    ./neovim.nix
  ];
in builtins.map (x: import x) overlays
