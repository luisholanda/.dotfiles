self: super:
{
  neovim-unwrapped = let
    ts = self.unstable.tree-sitter.override {
      enableStatic = true;
    };
  in super.neovim-unwrapped.overrideAttrs (old: rec {
    version = "c1fbc2ddf15b2f44b615f90b2511349ab974cb83";
    src = super.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = version;
      sha256 = "0kvk3r4by8r3asmfl69iw93xnd8lwfr0pynynlhr5y8h5pjd3rfi";
    };

    buildInputs = old.buildInputs ++ [ts];
  });
}
