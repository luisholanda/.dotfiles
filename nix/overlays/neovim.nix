self: super:
{
  neovim-unwrapped = let
    ts = self.unstable.tree-sitter.override {
      enableStatic = true;
    };
  in super.neovim-unwrapped.overrideAttrs (old: rec {
    version = "1a4d380b5abfff2cf5e46a1b00e98f4381b7e5b0";
    src = super.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = version;
      sha256 = "019dl8w0l2b0bk26irfgnl6dal1pisdwn1qy4b36hvij2y5mad3s";
    };

    buildInputs = old.buildInputs ++ [ts];
  });
}
