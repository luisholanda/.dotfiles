super@{ cfg, lib, pkgs, ... }:

let
  inherit (pkgs.stdenv) isLinux isDarwin;
  applications = with pkgs; if isLinux
    then [ tdesktop osu-lazer ]
    else [];

  otherPackages = with pkgs; let
    gcpPkgs = [ cloud-sql-proxy unstable.google-cloud-sdk ];
    lspPkgs = [ unstable.nodePackages.pyright rnix-lsp terraform-lsp rust-analyzer ];
  in [
    any-nix-shell
    devicon-lookup
    exa
    fishPlugins.foreign-env
    gitAndTools.gh
    git.doc
    httpie
    jq
    nixfmt
    ripgrep
    yarn
    protobuf
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
        CHROMIUM_FLAGS = lib.optionalString isLinux "--use-gl=desktop --enable-features=UseOzonePlatform --ozone-platform=wayland";
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
        ".config/brave-flags.conf".text = "--use-gl=desktop  --enable-features=UseOzonePlatform --ozone-platform=wayland";
      };
    };

    submoduleSupport = {
      enable = true;
      externalPackageInstall = false;
    };

    xdg = lib.mkIf isLinux {
      enable = true;
      userDirs.enable = true;
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
