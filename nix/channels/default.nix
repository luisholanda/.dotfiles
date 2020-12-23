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
    rev = "9f371adb3d2469b29a3e7bb9cc5e97c79b103a32";
    sha256 = "0b8lzapcnrqm5wvdlcr5w4l44jki5j6fc6n8ppzd218cic21cc8q";
  };
  homeManager = fetchFromGitHub {
    owner = "nix-community";
    repo = "home-manager";
    rev = "3627ec4de58d7fbda13c82dfec94eace10198f23";
    sha256 = "1dxhgsg7081c50h8z146lrhx6aj6f4h905f45im7ilj6c3q4z0z9";
  };
in rec {
  __nixPath = [
    { prefix = "nur"; src = nurRepos; }
    { prefix = "nixpkgs-unstable"; src = nixUnstable; }
    { prefix = "home-manager"; src = homeManager; }
    { prefix = "darwin"; src = nixDarwin; }
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
