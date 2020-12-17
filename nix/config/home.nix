super@{ lib, pkgs, ... }:

with pkgs.stdenv;
let
  applications = with pkgs; [
    unstable.alacritty
    gccemacs
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
    unstable.llvm_11
    protobuf
  ] ++ gcpPkgs
  ++ lspPkgs
  ++ (import ./scripts.nix super);

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
