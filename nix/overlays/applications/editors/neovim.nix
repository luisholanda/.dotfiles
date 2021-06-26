self: super:
{
  neovim-unwrapped = let
    ts = self.tree-sitter.override {
      enableStatic = true;
    };
  in (super.neovim-unwrapped
    .override { inherit (self) fish; nodejs = null; })
    .overrideAttrs (old: rec {
    version = "e680d7d6af4b48680693be9d984cce217e959e1f";
    src = super.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = version;
      sha256 = "1i977ky9pslrjrk70wm47hh89g32lkg0fzicxa9pj7p29zsrbcqw";
    };

    buildInputs = old.buildInputs ++ [ts];
  });
}
