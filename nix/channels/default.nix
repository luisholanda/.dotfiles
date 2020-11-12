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
    rev = "d49380f73b0389d3321d420086cd605ee6a0846f";
    sha256 = "0qw4757m3i9n61cd8544kd8ynl8m1zvjsh44mpgg3nm82i455csx";
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
    rev = "db11a42e7b0981a693ad6625e479aed9cac2aa94";
    sha256 = "16rr1g80rwvggvma97k0cd2fm0ykhx896jcpcc9p67878s5qvgva";
  };
in rec {
  __nixPath = [
    { prefix = "nur"; src = nurRepos; }
    { prefix = "nixpkgs-unstable"; src = nixUnstable; }
    { prefix = "darwin-config"; src = "${HOME}/.dotfiles/nix/darwin-configuration.nix"; }
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
