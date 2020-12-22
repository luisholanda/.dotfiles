self: super:
{
  neovim-unwrapped = let
    ts = self.unstable.tree-sitter.override {
      enableStatic = true;
    };
  in super.neovim-unwrapped.overrideAttrs (old: rec {
    version = "5e202f69b3e42b90bc0393b0cee3bfddd2678216";
    src = super.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = version;
      sha256 = "0z1rc9p1x3l57kr1mydzr5f6ac575nlsiqvd9qvvhi7lk2m2h9lr";
    };

    buildInputs = old.buildInputs ++ [ts];
  });
}
