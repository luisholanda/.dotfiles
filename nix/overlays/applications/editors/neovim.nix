self: super:
{
  neovim-unwrapped = let
    ts = self.tree-sitter.override {
      enableStatic = true;
    };
  in (super.neovim-unwrapped
    .override { inherit (self) fish; python = null; nodejs = null; })
    .overrideAttrs (old: rec {
    version = "3d25a72a60323c9d6eab2daf9dbd4920b94b8a94";
    src = super.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = version;
      sha256 = "1dwiwslxca8zjsdva5d1xbahl60f42qk6n7nngl75r70hmrw10b3";
    };

    buildInputs = old.buildInputs ++ [ts];
  });
}
