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
    rev = "013f2ce9b3f02f0d46a3f9ef39aefd61c603f89f";
    sha256 = "06w3n2m97v8aas5zbwl187q4zbdhqfxc0k1kmnwj953h9pczf3q9";
  };
  homeManager = fetchFromGitHub {
    owner = "nix-community";
    repo = "home-manager";
    rev = "0ada50fc9c620f7ad9f7c6ff70bf40514f4400a9";
    sha256 = "0zlgihyy3gwkb409lhrfnslhd3lcqar8vwp4mkcw8kvzjfz8vyqx";
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
