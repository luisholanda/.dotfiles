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
    useUserPackages = false;
    useGlobalPkgs = false;
    users.luiscm = myHomeConfig;
  };
}
