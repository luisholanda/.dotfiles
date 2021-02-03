self: super:
{
  neovim-unwrapped = let
    ts = self.unstable.tree-sitter.override {
      enableStatic = true;
    };
  in super.neovim-unwrapped.overrideAttrs (old: rec {
    version = "cc1851c9fdd6d777338bea2272d2a02c8baa0fb1";
    src = super.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = version;
      sha256 = "019dl8w0l2b0bk26irfgnl6dal1pisdwn1qy4b36hvij2y5mad3s";
    };

    buildInputs = old.buildInputs ++ [ts];
  });
}
