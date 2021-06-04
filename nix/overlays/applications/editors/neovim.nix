self: super:
{
  neovim-unwrapped = let
    ts = self.tree-sitter.override {
      enableStatic = true;
    };
  in (super.neovim-unwrapped
    .override { inherit (self) fish; nodejs = null; })
    .overrideAttrs (old: rec {
    version = "ca802046bf0667b211f72330619a18fec3fea5f0";
    src = super.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = version;
      sha256 = "05aswlzgqjy2v6ryh9mn0gskxq12xsl31pds6r69d0hdx9hcv1sj";
    };

    buildInputs = old.buildInputs ++ [ts];
  });
}
