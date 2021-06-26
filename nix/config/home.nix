super@{ cfg, lib, pkgs, ... }:

let
  inherit (pkgs.stdenv) isLinux isDarwin;
  inherit (pkgs.lib) optionalString mkIf;
  applications = with pkgs;
    if isLinux then [
      tdesktop
      nomacs
      pcmanfm
      texlab
      zathura
      minecraft
      osu-lazer
    ] else
      [ ];

  otherPackages = with pkgs;
    let
      gcpPkgs = [ cloud-sql-proxy google-cloud-sdk ];
      lspPkgs = [
        cmake-language-server
        nodePackages.pyright
        nodePackages.typescript-language-server
        nodePackages.vim-language-server
        rnix-lsp
        rust-analyzer
        terraform-lsp
      ];
      gitPkgs = [ gitAndTools.gh gitAndTools.git-absorb gitAndTools.stgit git.doc ];
    in [ exa fishPlugins.foreign-env httpie jq ripgrep ] ++ gcpPkgs ++ lspPkgs
    ++ gitPkgs ++ (import ./scripts.nix super);

  username = "luiscm";
  myHomeConfig = {
    programs = import ../programs super // { home-manager.enable = true; };

    home = {
      packages = otherPackages ++ applications;
      stateVersion = "21.03";
      sessionPath = [
        "$HOME/.pyenv/bin"
        "$HOME/.local/bin"
        "$HOME/.cargo/bin"
        "/run/current-system/sw/bin"
      ];

      sessionVariables = rec {
        MANPAGER = "nvim -c 'set ft=man' -";
        MANWIDTH = "88";
        EDITOR = "nvim";
        GIT_SEQUENCE_EDITOR = EDITOR;
        CHROMIUM_FLAGS = optionalString isLinux
          "--enable-features=UseOzonePlatform --ozone-platform=wayland";
        SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/ssh-agent";
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
        ".config/brave-flags.conf".text =
          mkIf isLinux "--enable-features=UseOzonePlatform --ozone-platform=wayland";
      };
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
