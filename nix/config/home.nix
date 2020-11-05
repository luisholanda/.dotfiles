super@{ lib, pkgs, ... }:

with pkgs.stdenv;
let
  applications = with pkgs; [
    alacritty
  ];

  otherPackages = with pkgs; let
    gcpPkgs = [ cloud-sql-proxy google-cloud-sdk ];
    lspPkgs = [ ccls gopls rnix-lsp terraform-lsp rust-analyzer ];
  in [
    bat
    exa
    fish-foreign-env
    gitAndTools.gh
    httpie
    jq
    nixfmt
    pkg-config
    yarn
    vagrant
  ] ++ gcpPkgs
  ++ lspPkgs;

  username = "luiscm";
  homeDirectory = if isDarwin
    then "/Users/${username}"
    else "/home/${username}";
  dotfiles = "${homeDirectory}/.dotfiles";
  myHomeConfig = {
    programs = import ../programs super // {
      home-manager.enable = true;
    };

    home = {
      inherit homeDirectory username;
      packages = otherPackages ++ applications;
      stateVersion = "20.09";
      sessionPath = [
        "${homeDirectory}/.pyenv/bin"
        "${homeDirectory}/.local/bin"
        "${homeDirectory}/.cargo/bin"
        "/run/current-system/sw/bin"
      ];
    };

    submoduleSupport = {
      enable = true;
      externalPackageInstall = false;
    };
  };
in {
  home-manager = {
    useUserPackages = false;
    useGlobalPkgs = false;
    users.luiscm = myHomeConfig;
  };
}
