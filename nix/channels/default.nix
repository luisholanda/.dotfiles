{ pkgs, ... }:
let
  lib = pkgs.lib;
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
    rev = "1f6d9acafc8c5ad382585fea0b9d72095ea3976a";
    sha256 = "1h58kgq6sgambhiybqg0wvqbvsl1ngxi4kl0laxs7khsmy4ircvb";
  };
  homeManager = fetchFromGitHub {
    owner = "nix-community";
    repo = "home-manager";
    rev = "90493027e33ba9eb3f50dc1da365d0e4ca31bf14";
    sha256 = "0jnxpc1ywnccri1d3m7hqrmxzifi65dk1zyh9xdlbx1fjm4x6xr5";
  };
  __nixPath = [
    { prefix = "nur"; src = nurRepos; }
    { prefix = "nixpkgs"; src = nixUnstable; }
    { prefix = "nixpkgs-unstable"; src = nixUnstable; }
    { prefix = "home-manager"; src = homeManager; }
  ] ++ lib.optionals pkgs.stdenv.isDarwin [
    { prefix = "darwin"; src = nixDarwin; }
    { prefix = "darwin-config"; src = "/Users/luiscm/.dotfiles/nix/configuration.nix"; }
  ] ++ lib.optional pkgs.stdenv.isLinux
    { prefix = "nixos-config"; src = "/home/luiscm/.dotfiles/nix/machines/plutus/configuration.nix"; };
in rec {
  nur = nurRepos;
  darwin = nixDarwin;
  nixpkgs-unstable = nixUnstable;
  home-manager = homeManager;
  nixPath = map ({ prefix, src }: { "${prefix}" = "${src}"; }) __nixPath
  ++ [
    "/nix/var/nix/profiles/per-user/luiscm/channels"
    "/nix/var/nix/profiles/per-user/root/channels"
  ];
  nixPathStr = map ({ prefix, src }: "${prefix}=${src}") __nixPath
  ++ [
    "/nix/var/nix/profiles/per-user/luiscm/channels"
    "/nix/var/nix/profiles/per-user/root/channels"
  ];
}
