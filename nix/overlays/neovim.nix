self: super:
{
  neovim-unwrapped = let
    ts = self.unstable.tree-sitter.override {
      enableStatic = true;
    };
  in super.neovim-unwrapped.overrideAttrs (old: rec {
    version = "c1fbc2ddf15b2f44b615f90b2511349ab974cb83";
    src = super.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = version;
      sha256 = "16p69fgv1pr5n1rx1mnvj7j4c310ygn8xmiysivjsmvra6w93i6y";
    };

    buildInputs = old.buildInputs ++ [ts];
  });
}
