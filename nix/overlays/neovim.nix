self: super:
{
  neovim-unwrapped = let
    ts = self.unstable.tree-sitter.override {
      enableStatic = true;
    };
  in super.neovim-unwrapped.overrideAttrs (old: rec {
    version = "0af5a56e47b543c8497eaa71ca8ff6900059d062";
    src = super.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = version;
      sha256 = "019dl8w0l2b0bk26irfgnl6dal1pisdwn1qy4b36hvij2y5mad3s";
    };

    buildInputs = old.buildInputs ++ [ts];
  });
}
