self: super:
{
  neovim-unwrapped = let
    ts = self.tree-sitter.override {
      enableStatic = true;
    };
  in (super.neovim-unwrapped
    .override { inherit (self) fish; nodejs = null; })
    .overrideAttrs (old: rec {
    version = "a282a177d3320db25fa8f854cbcdbe0bc6abde7f";
    src = super.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = version;
      sha256 = "03ckzr75jf1mps0y3v9rj2jifsfapkpqyxaw1rs5ify9zdmja593";
    };

    buildInputs = old.buildInputs ++ [ts];
  });
}
