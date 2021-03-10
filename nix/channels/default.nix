{ lib, pkgs, ... }:
let
  stdenv = pkgs.stdenv;
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
    rev = "870137af3c529722a449f7731890453583985edc";
    sha256 = "1mzlkq9nm3if6lh479w8i39cnky2kicas529s4yms87krmbz61w9";
  };
  homeManager = fetchFromGitHub {
    owner = "nix-community";
    repo = "home-manager";
    rev = "d8dd2a09b0a9c2c12d733f5d1eb3fa39bbe215b8";
    sha256 = "1dxhgsg7081c50h8z146lrhx6aj6f4h905f45im7ilj6c3q4z0z9";
  };
in rec {
  __nixPath = [
    { prefix = "nur"; src = nurRepos; }
    { prefix = "nixpkgs-unstable"; src = nixUnstable; }
    { prefix = "home-manager"; src = homeManager; }
  ] ++ lib.optionals stdenv.isDarwin [
    { prefix = "darwin"; src = nixDarwin; }
    { prefix = "darwin-config"; src = "${HOME}/.dotfiles/nix/configuration.nix"; }
  ] ++ lib.optional stdenv.isLinux
    { prefix = "nixos-config"; src = "${HOME}/.dotfiles/nix/machines/plutus/configuration.nix"; };
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

