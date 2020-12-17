let
  HOME = builtins.getEnv "HOME";
  fetchFromGitHub = { owner, repo, rev, sha256 }:
    builtins.fetchTarball {
      inherit sha256;
      url = "https://github.com/${owner}/${repo}/archive/${rev}.tar.gz";
    };

  nurRepos = fetchFromGitHub {
    owner = "nix-community";
    repo = "nur-combined";
    rev = "2c9ab535acd662cf07fed5c7ca2484164462f9c9";
    sha256 = "1l9py6qy6k6f1jc4vf4wk3cx7rxvhh042786lw6klrlgl8kx86aw";
  };
  nixDarwin = fetchFromGitHub {
    owner = "LnL7";
    repo = "nix-darwin";
    rev = "842c72f1c979cbcaefa65e25e7902743eefa3eb0";
    sha256 = "0000000000000000000000000000000000000000000000000000";
  };
  nixUnstable = fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs";
    rev = "919648ae9c3886ac23565f270f713f9e69b656db";
    sha256 = "0mi61nil7i3kb52knvfq5khibbhdghrxqc0n4mhb4652z2a3gq2q";
  };
in rec {
  __nixPath = [
    { prefix = "nur"; src = nurRepos; }
    { prefix = "nixpkgs-unstable"; src = nixUnstable; }
    { prefix = "darwin-config"; src = "${HOME}/.dotfiles/nix/configuration.nix"; }
  ];
  nixPath = map ({ prefix, src }: { "${prefix}" = "${src}"; }) __nixPath
  ++ [
    "/nix/var/nix/profiles/per-user/root/channels"
    "${HOME}/.nix-defexpr/channels"
  ];
  nixPathStr = map ({ prefix, src }: "${prefix}=${src}") __nixPath
  ++ [
    "/nix/var/nix/profiles/per-user/root/channels"
    "${HOME}/.nix-defexpr/channels"
  ];
}
