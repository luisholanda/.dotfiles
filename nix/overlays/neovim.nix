self: super:
{
  neovim-unwrapped = let
    ts = self.tree-sitter.override {
      enableStatic = true;
    };
  in (super.neovim-unwrapped
    .override { inherit (self) fish; python = null; nodejs = null; })
    .overrideAttrs (old: rec {
    version = "9808c8d9ddea2a8e29e7b979581ba67f8871a1b1";
    src = super.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = version;
      sha256 = "0msrya0xdl895igjpsxh31mm414pki9jm8k2ldmzk1ij407aabr5";
    };

    buildInputs = old.buildInputs ++ [ts];
  });
}
