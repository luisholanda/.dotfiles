self: super:
{
  neovim-unwrapped = super.neovim-unwrapped.overrideAttrs (old: {
    version = "nightly";
    src = super.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = "9fee5f14239512aed1096b17e8e755c87b9055d2";
      sha256 = "1pa7ggmx0l492hjgi3pwc5b9lccs7adgqkhcl859k7y365him6m7";
    };
  });
}
