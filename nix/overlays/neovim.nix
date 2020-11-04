self: super:
{
  neovim-unwrapped = super.neovim-unwrapped.overrideAttrs (old: rec {
    version = "432f3240f171e857beb3d1a554cbd8a649bb38ae";
    src = super.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = version;
      sha256 = "1drgaxnaazbv086pmy63254xm2madh8gl50kaynhbdwrrkxwcfzh";
    };
  });
}
