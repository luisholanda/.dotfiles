self: super:
{
  neovim-unwrapped = let
    ts = self.tree-sitter.override {
      enableStatic = true;
    };
  in (super.neovim-unwrapped
    .override { inherit (self) fish; nodejs = null; })
    .overrideAttrs (old: rec {
    version = "b585f723bcbaa10a091fce5a61659b331b1467b9";
    src = super.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = version;
      sha256 = "092vgwhgjmgyz272qpmp4grldrbzjklvh3ziaahydbp9xjcmzvmq";
    };

    buildInputs = old.buildInputs ++ [ts];
  });
}
