super@{ lib, pkgs, ... }:
let
  otherPackages = with pkgs; [
    bat
    ccls
    cloud-sql-proxy
    exa
    fish-foreign-env
    git
    gitAndTools.gh
    google-cloud-sdk
    gopls
    httpie
    jq
    nixfmt
    nmap
    pkg-config
    rnix-lsp
    terraform-lsp
    yarn
    vagrant
  ];

  username = "luiscm";
  homeDirectory = if pkgs.stdenv.isDarwin
    then "/Users/${username}"
    else "/home/${username}";
  dotfiles = "${homeDirectory}/.dotfiles";
  myHomeConfig = {
    imports = [ ../programs ];

    home = {
      inherit homeDirectory username;
      packages = otherPackages;
      stateVersion = "20.09";
      sessionPath = [
        "${homeDirectory}/.pyenv/bin"
        "${homeDirectory}/.local/bin"
        "${homeDirectory}/.cargo/bin"
        "/run/current-system/sw/bin"
      ];
    };


    nixpkgs.config.allowUnfree = true;
    nixpkgs.overlays = [
      (import ../overlays/neovim.nix)
    ];

    submoduleSupport = {
      enable = true;
      externalPackageInstall = false;
    };

    programs.home-manager.enable = true;
  };
in {
  home-manager = {
    useUserPackages = false;
    useGlobalPkgs = false;
    users.luiscm = myHomeConfig;
  };
}
