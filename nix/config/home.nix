super@{ lib, pkgs, ... }:

with pkgs.stdenv;
let
  applications = [ pkgs.telegram ];

  otherPackages = with pkgs; let
    gcpPkgs = [ cloud-sql-proxy unstable.google-cloud-sdk ];
    lspPkgs = [ rnix-lsp terraform-lsp rust-analyzer ];
  in [
    bat
    exa
    fishPlugins.foreign-env
    gitAndTools.gh
    git.doc
    httpie
    jq
    nixfmt
    yarn
    protobuf
    androidenv.androidPkgs_9_0.platform-tools
  ] ++ gcpPkgs
  ++ lspPkgs
  ++ (import ./scripts.nix super);

  username = "luiscm";
  myHomeConfig = {
    programs = import ../programs super // {
      home-manager.enable = true;
    };

    home = {
      packages = otherPackages ++ applications;
      stateVersion = "20.09";
      sessionPath = [
        "$HOME/.pyenv/bin"
        "$HOME/.local/bin"
        "$HOME/.cargo/bin"
        "/run/current-system/sw/bin"
      ];

      sessionVariables = {
        MANPAGER = "nvim -c 'set ft=man' -";
        EDITOR = "nvim";
      };

      file = {
        doomConfig = {
          source = ../../doom;
          target = ".config/doom";
        };
        kakouneConfig = {
          source = ../../kakrc;
          target = ".config/kak";
        };
        neovimConfig = {
          source = ../../nvim;
          target = ".config/nvim";
          # Prevent that we add generated files to git.
          recursive = true;
        };
      };
    };
  };
in {
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.luiscm = myHomeConfig;
    verbose = true;
  };
}
