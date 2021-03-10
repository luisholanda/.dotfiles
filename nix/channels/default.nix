let
  HOME = builtins.getEnv "HOME";
  fetchFromGitHub = { owner, repo, rev ? null, tag ? null, sha256 }:
    assert rev == null -> tag != null;
    builtins.fetchTarball {
      inherit sha256;
      url = let
        urlPrefix = "https://github.com/${owner}/${repo}/archive";
      in if tag == null
      then "${urlPrefix}/${rev}.tar.gz"
      else "${urlPrefix}/${tag}.tar.gz";
    };

  nurRepos = fetchFromGitHub {
    owner = "nix-community";
    repo = "nur-combined";
    rev = "25067d287b0f0330401136e5454957e55bbead4e";
    sha256 = "1fibmq6lsx8ja7w4ygc7cx6dqqgfjskjp8v59gl9s6p7xygf9c0i";
  };
  nixDarwin = fetchFromGitHub {
    owner = "LnL7";
    repo = "nix-darwin";
    rev = "0884b87b5c0cacf67a2ffd8dc8cd1d7c629ba8f6";
    sha256 = "1ag0ggsw75jxv95iywnfazykykx7llqc6mvn2zqdvrx9wy425d1y";
  };
  nixUnstable = fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs";
    rev = "fbecdac147c149e96ba0d79f7926c62c1eb1cf65";
    sha256 = "1mzlkq9nm3if6lh479w8i39cnky2kicas529s4yms87krmbz61w9";
  };
  homeManager = fetchFromGitHub {
    owner = "nix-community";
    repo = "home-manager";
    rev = "57a7e5e2c53de58215fdac1910470bef36dd30cd";
    sha256 = "0cgjai6l1j73h6mwgndcyha7wy6am2vwd25274lffzqzrs0n1ac9";
  };
in rec {
  nur = nurRepos;
  darwin = nixDarwin;
  nixpkgs-unstable = nixUnstable;
  home-manager = homeManager;
  __nixPath = [
    { prefix = "nur"; src = nurRepos; }
    { prefix = "nixpkgs-unstable"; src = nixUnstable; }
    { prefix = "home-manager"; src = homeManager; }
    { prefix = "darwin"; src = nixDarwin; }
  ];
  nixPath = map ({ prefix, src }: { "${prefix}" = "${src}"; }) __nixPath;
  nixPathStr = map ({ prefix, src }: "${prefix}=${src}") __nixPath;
}
