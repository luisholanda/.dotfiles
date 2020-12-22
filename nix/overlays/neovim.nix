self: super:
{
  neovim-unwrapped = let
    ts = self.unstable.tree-sitter.override {
      enableStatic = true;
    };
  in super.neovim-unwrapped.overrideAttrs (old: rec {
    version = "b931a554d70ef07803da3eb3f98ce4b3a3570d11";
    src = super.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = version;
      sha256 = "0grqh5955w8rgpkp8xspmkf81nvrlgqgspywdvn3bfm5ki0svgim";
    };

    buildInputs = old.buildInputs ++ [ts];
  });
}
