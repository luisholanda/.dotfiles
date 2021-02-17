self: super:
{
  neovim-unwrapped = let
    ts = self.unstable.tree-sitter.override {
      enableStatic = true;
    };
  in super.neovim-unwrapped.overrideAttrs (old: rec {
    version = "02a3c417945e7b7fc781906a78acbf88bd44c971";
    src = super.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = version;
      sha256 = "16p69fgv1pr5n1rx1mnvj7j4c310ygn8xmiysivjsmvra6w93i6y";
    };

    buildInputs = old.buildInputs ++ [ts];
  });
}
