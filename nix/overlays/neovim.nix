self: super:
{
  neovim-unwrapped = let
    ts = self.unstable.tree-sitter.override { enableStatic = true; };
  in super.neovim-unwrapped.overrideAttrs (old: rec {
    version = "6d58f1eacef4be410c424f5f0e23c20ffdd791be";
    src = super.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = version;
      sha256 = "1il6ch8sv7bghc0fcx3ja0lz8i7gqrl783cyvkn4kna551sm5y9a";
    };

    buildInputs = old.buildInputs ++ [ts];
  });
}
