super@{ config, lib, pkgs, ... }:

let
  otherPackages = with pkgs; [
    bat
    ccls
    exa
    fish-foreign-env
    git
    gitAndTools.gh
    google-cloud-sdk
    httpie
    jq
    nixfmt
    nmap
    pinentry_mac
    pkg-config
    rnix-lsp
    terraform-lsp
    yarn
    vagrant
  ];

  homeDirectory = builtins.getEnv "HOME";
  dotfiles = "${homeDirectory}/.dotfiles";
in rec {
  home = {
    inherit homeDirectory;
    packages = otherPackages ++ lib.optional programs.go.enable pkgs.gopls;
    username = "luiscm";
    stateVersion = "20.09";
    sessionPath = [
      "${homeDirectory}/.pyenv/bin"
      "${homeDirectory}/.local/bin"
      "${homeDirectory}/.cargo/bin"
      "/run/current-system/sw/bin"
    ];
  };


  imports = [ ./programs ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    (import ./overlays/neovim.nix)
  ];

  submoduleSupport = {
    enable = true;
    externalPackageInstall = false;
  };

  programs.home-manager.enable = true;
}
